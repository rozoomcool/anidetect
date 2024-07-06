import os
from datetime import datetime

from PIL.ExifTags import TAGS
from PIL.Image import Image


def get_exif_data(image_path):
    image = Image.open(image_path)
    exif_data = image._getexif()
    if not exif_data:
        return None
    exif = {TAGS.get(tag): value for tag, value in exif_data.items()}
    return exif

def get_image_date(exif):
    if 'DateTimeOriginal' in exif:
        return datetime.strptime(exif['DateTimeOriginal'], '%Y:%m:%d %H:%M:%S')
    elif 'DateTime' in exif:
        return datetime.strptime(exif['DateTime'], '%Y:%m:%d %H:%M:%S')
    return None


def process_folder(folder_path, class_name):
    results = []
    for folder_name in os.listdir(folder_path):
        subfolder_path = os.path.join(folder_path, folder_name)
        if not os.path.isdir(subfolder_path):
            continue

        camera_id = folder_name
        image_dates = []

        for file_name in os.listdir(subfolder_path):
            if file_name.lower().endswith(('jpg', 'jpeg', 'png')):
                image_path = os.path.join(subfolder_path, file_name)
                exif = get_exif_data(image_path)
                if exif:
                    image_date = get_image_date(exif)
                    if image_date:
                        image_dates.append(image_date)

        if not image_dates:
            continue

            # Сортируем даты
        image_dates.sort()

        # Ищем промежутки времени
        start_date = image_dates[0]
        end_date = start_date
        count = 1

        for i in range(1, len(image_dates)):
            if (image_dates[i] - image_dates[i - 1]).total_seconds() <= 60:  # Промежуток в 1 минуту
                end_date = image_dates[i]
                count += 1
            else:
                results.append((camera_id, class_name, start_date, end_date, count))
                start_date = image_dates[i]
                end_date = start_date
                count = 1

        results.append((camera_id, class_name, start_date, end_date, count))
    return results



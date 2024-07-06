bool isImageFile(String fileName) {
  final RegExp imageFileRegExp = RegExp(r'^.*\.(jpg|jpeg|png|gif|bmp|webp|tiff)$', caseSensitive: false);
  return imageFileRegExp.hasMatch(fileName.toLowerCase());
}

final pathRegex = RegExp(r'[\\/]+');
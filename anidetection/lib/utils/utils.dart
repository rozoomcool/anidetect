const String baseUrl = "http://localhost:8000";

int calculateDifferenceInMinutes(DateTime startDate, DateTime endDate) {
  // Вычисляем разницу между двумя датами
  Duration difference = endDate.difference(startDate);

  // Возвращаем разницу в минутах
  return difference.inMinutes;
}
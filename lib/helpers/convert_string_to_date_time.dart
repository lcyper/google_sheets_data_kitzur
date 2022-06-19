DateTime convertStringToDateTime(String date) {
  final List<String> dateList =
      date.replaceAll('/', '-').split('-').reversed.toList();
  dateList[1] = dateList[1].padLeft(2, '0');
  dateList[2] = dateList[2].padLeft(2, '0');
  return DateTime.parse(dateList.join('-'));
}

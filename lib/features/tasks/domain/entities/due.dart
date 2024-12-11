class Due {
  const Due({
    required this.date,
    required this.isRecurring,
    required this.datetime,
    required this.string,
    required this.timezone,
  });
  final String date;
  final bool isRecurring;
  final DateTime datetime;
  final String string;
  final String timezone;
}

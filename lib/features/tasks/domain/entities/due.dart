class Due {
  const Due({
    this.date,
    this.isRecurring,
    this.datetime,
    this.string,
    this.timezone,
  });

  final String? date;
  final bool? isRecurring;
  final DateTime? datetime;
  final String? string;
  final String? timezone;

  Due copyWith({
    String? Function()? date,
    bool? Function()? isRecurring,
    DateTime? Function()? datetime,
    String? Function()? string,
    String? Function()? timezone,
  }) {
    return Due(
      date: date != null ? date() : this.date,
      isRecurring: isRecurring != null ? isRecurring() : this.isRecurring,
      datetime: datetime != null ? datetime() : this.datetime,
      string: string != null ? string() : this.string,
      timezone: timezone != null ? timezone() : this.timezone,
    );
  }
}

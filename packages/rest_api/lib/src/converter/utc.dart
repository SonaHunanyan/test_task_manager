import 'package:freezed_annotation/freezed_annotation.dart';

class UTCConverter implements JsonConverter<DateTime?, String?> {
  const UTCConverter();

  @override
  DateTime? fromJson(String? timestamp) {
    if (timestamp == null) {
      return null;
    }
    final date = DateTime.tryParse(timestamp);
    if (date == null) {
      return null;
    }
    return date.toLocal();
  }

  @override
  String? toJson(DateTime? date) {
    final utc = date?.toUtc();
    if (utc == null) {
      return null;
    }
    return utc.toString();
  }
}

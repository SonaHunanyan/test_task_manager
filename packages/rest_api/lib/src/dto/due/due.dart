import 'package:json_annotation/json_annotation.dart';
import 'package:rest_api/src/converter/utc.dart';

part 'due.g.dart';

@JsonSerializable()
class DueDto {
  const DueDto({
    this.date,
    this.isRecurring,
    this.datetime,
    this.string,
    this.timezone,
  });
  final String? date;
  @JsonKey(name: 'is_recurring')
  final bool? isRecurring;
  @UTCConverter()
  final DateTime? datetime;
  final String? string;
  final String? timezone;

  factory DueDto.fromJson(Map<String, dynamic> json) => _$DueDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DueDtoToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'due.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DueDto _$DueDtoFromJson(Map<String, dynamic> json) => DueDto(
      date: json['date'] as String,
      isRecurring: json['is_recurring'] as bool,
      datetime: DateTime.parse(json['datetime'] as String),
      string: json['string'] as String,
      timezone: json['timezone'] as String,
    );

Map<String, dynamic> _$DueDtoToJson(DueDto instance) => <String, dynamic>{
      'date': instance.date,
      'is_recurring': instance.isRecurring,
      'datetime': instance.datetime.toIso8601String(),
      'string': instance.string,
      'timezone': instance.timezone,
    };

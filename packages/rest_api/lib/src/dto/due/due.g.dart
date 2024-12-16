// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'due.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DueDto _$DueDtoFromJson(Map<String, dynamic> json) => DueDto(
      date: json['date'] as String?,
      isRecurring: json['is_recurring'] as bool?,
      datetime: const UTCConverter().fromJson(json['datetime'] as String?),
      string: json['string'] as String?,
      timezone: json['timezone'] as String?,
    );

Map<String, dynamic> _$DueDtoToJson(DueDto instance) => <String, dynamic>{
      'date': instance.date,
      'is_recurring': instance.isRecurring,
      'datetime': const UTCConverter().toJson(instance.datetime),
      'string': instance.string,
      'timezone': instance.timezone,
    };

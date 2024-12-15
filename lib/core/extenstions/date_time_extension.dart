import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  String toPrimaryFormat() => DateFormat.yMd().format(this);
}

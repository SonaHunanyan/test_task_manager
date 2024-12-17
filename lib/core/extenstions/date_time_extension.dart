import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  String toPrimaryFormat() => DateFormat('dd.MM.yyyy').format(this);
  String toCommentFormat() => DateFormat.Hm().format(this);
}

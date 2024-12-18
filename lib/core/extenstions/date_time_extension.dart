import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  String toPrimaryFormat() => DateFormat('dd.MM.yyyy').format(this);
  String toCommentFormat() => DateFormat.Hm().format(this);
  String toHistoryFormat() => DateFormat('dd.MM.yyyy hh:mm').format(this);
}

extension TimeStampExtension on int {
  String toHistoryFormat() =>
      DateTime.fromMillisecondsSinceEpoch(this).toHistoryFormat();
}

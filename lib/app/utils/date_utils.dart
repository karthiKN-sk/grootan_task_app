import 'package:intl/intl.dart';

///Date Check today yesterday other
String checkDateTime(String date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final others = DateTime(now.year, now.month, now.day - 2);

  final dateToCheck = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
  String time = DateFormat.jm().format(dateToCheck);
  final aDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
  String? checkDate = "";
  if (aDate == today) {
    checkDate = "Today, $time";
  } else if (aDate == yesterday) {
    checkDate = "Yesterday, $time";
  } else if (aDate == others) {
    checkDate = "${DateFormat('yMd').format(others)}, $time";
  }

  return checkDate;
}

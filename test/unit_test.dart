import 'package:flutter_test/flutter_test.dart';
import 'package:grootan_task_app/app/utils/date_utils.dart';
import 'package:intl/intl.dart';

void main() {
  ///
  ///Today DateTime
  test('Get Today from DateTime String', () {
    ///
    String intialDate = DateTime.now().toString();
    final dateToCheck = DateFormat("yyyy-MM-dd HH:mm:ss").parse(intialDate);
    String time = DateFormat.jm().format(dateToCheck);

    ///Function Check
    String dateTimeToday = checkDateTime(intialDate);

    ///Expected
    expect(dateTimeToday, "Today, $time");
  });

  ///Yesterday DateTime
  test('Get Yesterday from DateTime String', () {
    ///
    String intialDate = DateTime.now().toString();
    final dateToCheck = DateFormat("yyyy-MM-dd HH:mm:ss").parse(intialDate);
    final yesterday = DateTime(
        dateToCheck.year,
        dateToCheck.month,
        dateToCheck.day - 1,
        dateToCheck.hour,
        dateToCheck.minute,
        dateToCheck.second);
    String time = DateFormat.jm().format(yesterday);

    ///Function Check
    String dateTimeToday = checkDateTime(yesterday.toString());

    ///Expected
    expect(dateTimeToday, "Yesterday, $time");
  });

  ///Others DateTime
  test('Get Others from DateTime String', () {
    ///
    String intialDate = DateTime.now().toString();
    final dateToCheck = DateFormat("yyyy-MM-dd HH:mm:ss").parse(intialDate);
    final others = DateTime(
        dateToCheck.year,
        dateToCheck.month,
        dateToCheck.day - 2,
        dateToCheck.hour,
        dateToCheck.minute,
        dateToCheck.second);
    String time = DateFormat.jm().format(others);

    ///Function Check
    String dateTimeToday = checkDateTime(others.toString());

    ///Expected
    expect(dateTimeToday, "${DateFormat('yMd').format(others)}, $time");
  });
}

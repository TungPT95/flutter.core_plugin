import 'package:intl/intl.dart';

const _hour = 'H';
const _minute = 'm';
const _second = 's';
const _day = 'd';
const _month = 'M';
const _year = 'y';

class DataTimeUtils {
  static const String FORMAT_DEFAULT = '${_hour + _hour}:${_minute +
      _minute}:${_second + _second}';
  static const String FORMAT_1 = '${_hour + _hour}:${_minute +
      _minute} ${_day + _day}/${_month + _month}/${_year + _year + _year +
      _year}';

  static String milliSecondToDateString(int milliseconds,
      {String format = FORMAT_DEFAULT}) =>
      DateFormat(format)
          .format(DateTime.fromMillisecondsSinceEpoch(milliseconds,isUtc: true));
}

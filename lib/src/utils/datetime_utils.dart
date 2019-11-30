import 'package:intl/intl.dart';

const String FORMAT_DEFAULT = 'HH:mm:ss';
const String FORMAT_1 = 'HH:mm:ss mm/dd/yyyy';

class DataTimeUtils {
  static String milliSecondToDateString(int milliseconds,
          {String format = FORMAT_DEFAULT}) =>
      DateFormat(format)
          .format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
}

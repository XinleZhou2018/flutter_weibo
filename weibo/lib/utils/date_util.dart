import 'package:intl/intl.dart';

class DateUtil {
  static const String format_1 = "yyyyMMdd'T'HHmmss'Z'";

  static String formateDateTime(DateTime dateTime) {
    DateFormat dateFormat = DateFormat(format_1);

    return dateFormat.format(dateTime);
  }

  static int currentTimeMillis() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}

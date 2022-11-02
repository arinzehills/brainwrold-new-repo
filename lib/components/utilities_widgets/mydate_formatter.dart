import 'package:intl/intl.dart';

class MyDateFormatter {
  static format(format, datetime) => DateFormat(format).format(datetime);
  static String dateFormatter(
      {required DateTime datetime, bool showHours = false}) {
    String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String datetimeFormat = DateFormat('yyyy-MM-dd').format(datetime);
    final yesterday = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);
    //single day comparison
    String dayFormat = DateFormat('dd').format(datetime);

    if (dateNow == datetimeFormat) {
      if (showHours) {
        final differenceInTime = DateTime.now().difference(datetime).inMinutes;
        if (differenceInTime <= 60) {
          return '${differenceInTime} min ago';
        } else {
          final differenceInTime = DateTime.now().difference(datetime).inHours;
          return '${differenceInTime} hours ago';
        }
      }
      return 'Today at ${format('KK:mm a', datetime)}';
    } else if (format('yyyy-MM-dd', yesterday) ==
        format('yyyy-MM-dd', datetime)) {
      return 'Yesterday at ${format('KK:mm a', datetime)}';
    } else {
      return datetimeFormat;
    }
  }
}

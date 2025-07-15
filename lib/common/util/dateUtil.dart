import '../common.dart';

class DateUtil {
  static String getGlobalDate(DateTime time) {
    String formattedTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(time.toUtc());
    return formattedTime;
  }

  static String formatTimestampToString(DateTime timestamp,
      {bool withTime = false}) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    if (withTime) {
      return DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);
    } else {
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }
  }

  static DateTime formatStringToTimestamp(String dateTimeString) {
    DateTime dateTime = DateFormat('dd/MM/yyyy hh:mm a').parse(dateTimeString);
    return dateTime;
  }

  static Duration calculateDifference(
      DateTime firstDateTime, DateTime secondDateTime) {
    Duration difference = firstDateTime.difference(secondDateTime);

    return difference;
  }
}

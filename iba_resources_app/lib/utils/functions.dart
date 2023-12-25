class Utils {
  static String truncateString(String input) {
    const int maxLength = 95;

    if (input.length <= maxLength) {
      return input;
    } else {
      return '${input.substring(0, maxLength)}...';
    }
  }

  static String formatTimeAgo(String datetimeString) {
    DateTime postedTime = DateTime.parse(datetimeString);
    DateTime currentTime = DateTime.now();
    Duration difference = currentTime.difference(postedTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${_pluralize(difference.inMinutes, "minute")} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${_pluralize(difference.inHours, "hour")} ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} ${_pluralize(difference.inDays, "day")} ago';
    } else {
      int months = (difference.inDays / 30).floor();
      return '$months ${_pluralize(months, "month")} ago';
    }
  }

  static String _pluralize(int value, String unit) {
    return value == 1 ? unit : '${unit}s';
  }
}

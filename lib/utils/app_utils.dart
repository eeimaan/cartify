
import 'package:flutter_application_1/models/models.dart';
import 'package:intl/intl.dart';


String formatTimestamp(DateTime timestamp) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(timestamp);

  if (difference.inMinutes < 1) {
    return 'just now';
  } else if (difference.inHours < 1) {
    final minutes = difference.inMinutes;
    return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
  } else if (difference.inDays < 1) {
    if (difference.inHours == 24) {
      return '24 hours ago';
    } else {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    }
  } else if (difference.inDays == 1) {
    return 'yesterday at ${DateFormat('h:mm a').format(timestamp)}';
  } else {
    final days = difference.inDays;
    return '$days ${days == 1 ? 'day' : 'days'} ago at ${DateFormat('h:mm a').format(timestamp)}';
  }
}

String formatOrderDate(dynamic dateTime) {
  if (dateTime is String) {
    dateTime = DateTime.parse(dateTime);
  }

  if (dateTime is DateTime) {
    return DateFormat('dd MMM yyyy \'at\' hh:mm a').format(dateTime);
  } else {
    return '';
  }
}

double calculateAverageStarCount(List<Reviews> reviews) {
  if (reviews.isEmpty) {
    return 0.0;
  }

  num? totalStarCount =
      reviews.map((review) => review.starsCount).reduce((a, b) => a! + b!);

  double averageStarCount = totalStarCount! / reviews.length;

  return double.parse(averageStarCount.toStringAsFixed(1));
}




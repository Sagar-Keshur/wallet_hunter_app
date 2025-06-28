import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get dateMonthYearFormat {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String get yearMonthDateFormate {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get fileName {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get monthDateYearFormate {
    return DateFormat('MMM dd, yyyy').format(this);
  }

  String get minutesAgo {
    return '${difference(DateTime.now()).inMinutes} minutes ago';
  }

  String get toSubscriptionDate {
    return DateFormat('MMMM d, yyyy').format(this);
  }

  String get timeAgo {
    final now = DateTime.now().toUtc();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}

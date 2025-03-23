import 'package:intl/intl.dart';

class DateUtil {
  static final DateFormat _fullDateFormat = DateFormat('MMM dd, yyyy');
  static final DateFormat _timeFormat = DateFormat('hh:mm a');
  static final DateFormat _dayMonthFormat = DateFormat('MMM dd');
  
  static String formatDate(DateTime? date) {
    if (date == null) return 'No date';
    return _fullDateFormat.format(date);
  }
  
  static String formatTime(DateTime? date) {
    if (date == null) return 'No time';
    return _timeFormat.format(date);
  }
  
  static String formatDateTime(DateTime? date) {
    if (date == null) return 'No date';
    return '${_fullDateFormat.format(date)} ${_timeFormat.format(date)}';
  }
  
  static String formatDayMonth(DateTime? date) {
    if (date == null) return 'No date';
    return _dayMonthFormat.format(date);
  }
  
  static String getRelativeTime(DateTime? date) {
    if (date == null) return 'No date';
    
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} year(s) ago';
    }
    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month(s) ago';
    }
    if (difference.inDays > 0) {
      return '${difference.inDays} day(s) ago';
    }
    if (difference.inHours > 0) {
      return '${difference.inHours} hour(s) ago';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute(s) ago';
    }
    return 'Just now';
  }
  
  static String getDueStatus(DateTime? date) {
    if (date == null) return 'No due date';
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDate = DateTime(date.year, date.month, date.day);
    
    final difference = dueDate.difference(today).inDays;
    
    if (difference < 0) {
      return 'Overdue';
    }
    if (difference == 0) {
      return 'Due today';
    }
    if (difference == 1) {
      return 'Due tomorrow';
    }
    if (difference < 7) {
      return 'Due in $difference days';
    }
    return 'Due on ${formatDate(date)}';
  }
} 
import 'package:intl/intl.dart';

extension CurrencyFormatExtention on num? {
  String currencyFormat() {
    final usCurrency = NumberFormat('#,##0', 'en_US');
    String balanceReturn =
        usCurrency.format(this ?? 0); // Handle null with a default value
    return balanceReturn;
  }
}

extension DateAndTimeFormatExtension on DateTime {
  String dateAndTimeFormatExtension() {
    return DateFormat('dd/MM/yyyy - hh:mm a').format(this);
  }
}

extension DateFormatExtension on DateTime {
  String dateFormatExtension() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}

extension TimeFormatExtension on DateTime {
  String timeFormatExtension() {
    return DateFormat('hh:mm a').format(this);
  }
}

extension WeekFormatExtension on DateTime {
  String weekFormatExtension() {
    final today = DateTime.now();
    if (isToday(today)) {
      return 'Today ${DateFormat('hh:mm a').format(this)}';
    } else if (isYesterday(today)) {
      return 'Yesterday ${DateFormat('hh:mm a').format(this)}';
    } else {
      return DateFormat('EE hh:mm a').format(this);
    }
  }

  bool isToday(DateTime today) {
    return year == today.year && month == today.month && day == today.day;
  }

  bool isYesterday(DateTime today) {
    final yesterday = today.subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }
}

extension NameOfTheDayFormatExtension on DateTime {
  String nameOfTheDayFormatExtension() {
    return DateFormat('EEEE').format(this);
  }
}

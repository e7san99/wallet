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

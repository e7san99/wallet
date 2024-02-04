import 'package:intl/intl.dart';

extension CurrencyFormatExtention on num? {
  String currencyFormat() {
    final usCurrency = NumberFormat('#,##0', 'en_US');
    String balanceReturn =
        usCurrency.format(this ?? 0); // Handle null with a default value
    return balanceReturn;
  }
}

extension DateFormatExtension on DateTime {
  String dateFormatExtention() {
    return DateFormat('dd/MM/yyyy - hh:mm a').format(this);
  }
}

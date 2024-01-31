import 'package:intl/intl.dart';

extension CurrencyFormatIQD on num? {
  String currencyFormat() {
    final usCurrency = NumberFormat('#,##0', 'en_US');
    String balanceReturn = usCurrency.format(this ?? 0); // Handle null with a default value
    return balanceReturn;
  }
}
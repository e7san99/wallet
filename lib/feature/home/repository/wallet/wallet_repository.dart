import 'package:wallet/feature/home/home.dart';

abstract class WalletRepository {
  Future<bool> updateBalance(num balance);
  Stream<Wallet?> getWallet();
  Future<bool> sendBalance(String phone, String cuurentUsername ,num balance);
  Future<bool> checkPhoneNumber(String phone);
  Future<List<TransactionModel>?> getTransactions(String secondUsername, String balance);
}

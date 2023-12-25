import 'package:wallet/feature/home/model/wallet.dart';

abstract class WalletRepository {
  Future<bool> updateBalance(num balance);
  Future<Wallet?> getWallet();
}

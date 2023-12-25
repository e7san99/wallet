import 'package:wallet/feature/home/home.dart';
import 'package:wallet/feature/home/repository/wallet/wallet_repository.dart';
import 'package:wallet/feature/register/view/view.dart';

class WalletImplement extends WalletRepository {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Future<bool> updateBalance(num balance) async {
    final uid = firebaseAuth.currentUser!.uid;

    try {
      final query = await firebaseFirestore
          .collection('Balance')
          .where('uid', isEqualTo: uid)
          .get();

      await firebaseFirestore
          .collection('Balance')
          .doc(query.docs.first.id)
          .update({'balance': balance});

      return true;
    } catch (e) {
      print('===tomething is wrong in AddaAlanceImplement:  $e ===');
      return false;
    }
  }

  @override
  Future<Wallet?> getWallet() async {
    final uid = firebaseAuth.currentUser!.uid;
    final query = await firebaseFirestore
        .collection('Balance')
        .where('uid', isEqualTo: uid)
        .get();

    return Wallet.fromSnapshot(query.docs.first);
  }
}

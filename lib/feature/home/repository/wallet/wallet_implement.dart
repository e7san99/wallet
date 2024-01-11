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
      print('===tomething is wrong in update balance:  $e ===');
      return false;
    }
  }

@override
Stream<Wallet?> getWallet() {
  final uid = firebaseAuth.currentUser!.uid;
  return firebaseFirestore
      .collection('Balance')
      .where('uid', isEqualTo: uid)
      .snapshots()
      .map((querySnapshot) {
    if (querySnapshot.docs.isNotEmpty) {
      return Wallet.fromSnapshot(querySnapshot.docs.first);
    } else {
      return null;
    }
  });
}

  // @override
  // Future<Wallet?> getWallet() async {
  //   final uid = firebaseAuth.currentUser!.uid;
  //   final query = await firebaseFirestore
  //       .collection('Balance')
  //       .where('uid', isEqualTo: uid)
  //       .get();

  //   return Wallet.fromSnapshot(query.docs.first);
  // }

  @override
  Future<bool> sendBalance(String phone, num balance) async {
    try {
      final query = await firebaseFirestore
          .collection('Userr')
          .where('phone', isEqualTo: phone)
          .get();

     var user = MyUser.fromSnapshot(query.docs.first);

      final wallet = await firebaseFirestore
          .collection('Balance')
          .where('uid', isEqualTo: user.uid)
          .get();

      var bal = Wallet.fromSnapshot(wallet.docs.first);
      balance += bal.balance ?? 0;

      await firebaseFirestore
          .collection('Balance')
          .doc(wallet.docs.first.id)
          .update({
        'balance': balance,
      });
      return true;
    } catch (e) {
      print('===tomething is wrong in send balance:  $e ===');
      return false;
    }
  }
}

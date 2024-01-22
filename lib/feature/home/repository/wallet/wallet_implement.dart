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

  @override
  Future<bool> sendBalance(
      String phone, String cuurentUsername, num balance) async {
    final currentUid = firebaseAuth.currentUser?.uid;
    try {
      ////////// current
      await firebaseFirestore
          .collection('Userr')
          .where('username', isEqualTo: cuurentUsername)
          .get();

      final query = await firebaseFirestore
          .collection('Userr')
          .where('phone', isEqualTo: phone)
          .get();

      //second device user
      var user = MyUser.fromSnapshot(query.docs.first);

      final wallet = await firebaseFirestore
          .collection('Balance')
          .where('uid', isEqualTo: user.uid)
          .get();

      var sendBalance = Wallet.fromSnapshot(wallet.docs.first);

      //transaction
      await firebaseFirestore.collection('Transaction').doc().set({
        'currentUid': currentUid,
        'secondUid': user.uid,
        'currentUsername': cuurentUsername,
        'secondUsername': user.username,
        'balance': balance,
        // 'dateTime': DateTime.now(),
      });
      //////////////////

      balance += sendBalance.balance ?? 0;

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

  @override
  Future<bool> checkPhoneNumber(String phone) async {
    try {
      final query = await firebaseFirestore
          .collection('Userr')
          .where('phone', isEqualTo: phone)
          .get();
      if (query.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error checking phone number: $e');
      return false;
    }
  }

  @override
Stream<List<TransactionModel>?> getTransactions() {
  final currentUid = firebaseAuth.currentUser?.uid;

  return firebaseFirestore
        .collection('Transaction')
        .where('currentUid', isEqualTo: currentUid)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
       // Convert the list of documents to a list of TransactionModel objects
        List<TransactionModel> transactions = querySnapshot.docs.map((doc) {
          return TransactionModel.fromSnapshot(doc);
        }).toList();

        return transactions;
      } else {
        return null;
      }
    });

  // final query1 = await firebaseFirestore
  //     .collection('Transaction')
  //     .where('currentUid', isEqualTo: currentUid)
  //     .get();

  // final query2 = await firebaseFirestore
  //     .collection('Transaction')
  //     .where('secondUsername', isEqualTo: secondUsername)
  //     .get();

  // final query3 = await firebaseFirestore
  //     .collection('Transaction')
  //     .where('balance', isEqualTo: balance)
  //     .get();

  // List<TransactionModel> listOfTransaction = [...query1.docs, ...query2.docs, ...query3.docs]
  //     .map((doc) => TransactionModel.fromSnapshot(doc))
  //     .toList();

  // return listOfTransaction;
}
}
/*
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
*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallet/feature/register/model/user.dart';
import 'package:wallet/feature/register/repository/auth_repository.dart';

class AuthImplement extends AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<MyUser?> createUser(MyUser myUser, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: myUser.email!, password: password);
      myUser = myUser.copyWith(uid: userCredential.user!.uid);
      await _db.collection('Userr').add(myUser.toMap());

      return myUser;
    } catch (e) {
      print('something is wrong');
    }
    return null;
  }

  // Future<List<MyUser>> getCustomerList() async {
  //   final query = await _db.collection('Userr').get();

  //   final queryMap = query.docs.map((e) => MyUser.fromSnapshot(e)).toList();

  //   return queryMap;
  // }

  @override
  Future<User?> signin(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return null;
    }
    return firebaseAuth.currentUser;
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      print('something is wrong');
    }
  }
}

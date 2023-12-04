import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallet/feature/register/model/user.dart';
import 'package:wallet/feature/register/repository/auth_repository.dart';

class AuthImplement extends AuthRepository {
  AuthImplement(this.firebaseAuth, this._db);
  FirebaseAuth firebaseAuth;
  final FirebaseFirestore _db;

  static const myUser = 'Userr';

  @override
  Future<User?> signup(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print('something is wrong');
    }
    return null;
  }

  @override
  Future<User?> signin(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print('something is wrong');
    }
    return null;
  }
  

  @override
  Future<User?> createUser(MyUser myUser, String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    myUser = myUser.copyWith(uid: userCredential.user!.uid);

    final userrCollection = _db.collection(myUser.uid!);
    await userrCollection.doc(myUser.username).set(
      {
        'username': myUser.username,
        'phone': myUser.phone,
        'email': myUser.email,
      },
    );
    return userCredential.user;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet/feature/register/repository/auth_repository.dart';

class AuthImplement extends AuthRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  
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
}

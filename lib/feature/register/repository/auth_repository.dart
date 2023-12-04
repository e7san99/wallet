import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet/feature/register/model/user.dart';

abstract class AuthRepository {
  Future<User?> signup(
    String email,
    String password,
  );

  Future<User?> signin(
    String email,
    String password,
  );


  Future<void> createUser(
    MyUser myUser,
    String email,
    String password,
  );

}

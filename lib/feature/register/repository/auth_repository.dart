import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet/feature/register/model/user.dart';

abstract class AuthRepository {
  Future<MyUser?> createUser(
    MyUser myUser,
    String password,
  );

  Future<MyUser?> signin(
    String email,
    String password,
  );

  Future<void> logout();

  Future<MyUser?> getMyUser(String? uid);
}

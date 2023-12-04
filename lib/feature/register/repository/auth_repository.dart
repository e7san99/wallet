import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signup(
    String email,
    String password,
  );

  Future<User?> signin(
    String email,
    String password,
  );
}

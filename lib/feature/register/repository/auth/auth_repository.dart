import 'package:wallet/feature/register/repository/repository.dart';

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
  Future<List<MyUser?>?> getListOfMyUser();
}

import 'package:wallet/feature/register/repository/repository.dart';

class ForgotImplement extends ForgotRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Future<void> forgotAccount(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('=== something is wrong in Forgot Account: $e ===');
    }
  }
}

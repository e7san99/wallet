import 'package:wallet/feature/register/repository/repository.dart';

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
      print(' ==== something is wrong in create User: $e ===');
    }
    return null;
  }

  @override
  Future<MyUser?> signin(String email, String password) async {
    try {
      final user = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final data = await _db
          .collection('Userr')
          .where('uid', isEqualTo: user.user?.uid)
          .get();

      return MyUser.fromSnapshot(data.docs.first);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      print(' ==== something is wrong in logout : $e ===');
    }
  }

  @override
  Future<MyUser?> getMyUser(String? uid) async {
    try {
      final query =
          await _db.collection('Userr').where('uid', isEqualTo: uid).get();
      return MyUser.fromSnapshot(query.docs.first);
    } catch (e) {
      print(' ==== something is wrong in  getUser : $e ===');
    }
    return null;
  }
}

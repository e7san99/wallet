// import 'package:wallet/feature/home/repository/get_users/get_users_repository.dart';
// import 'package:wallet/feature/register/repository/repository.dart';

// class GetUsersImplement extends GetUsersRepository {
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   @override
//   Future<MyUser?> getMyUser(String? uid) async {
//     try {
//       final query = await firebaseFirestore
//           .collection('Userr')
//           .where('uid', isEqualTo: uid)
//           .get();
//       return MyUser.fromSnapshot(query.docs.first);
//     } catch (e) {
//       print(' ==== something is wrong in  getUser : $e ===');
//     }
//     return null;
//   }
// }

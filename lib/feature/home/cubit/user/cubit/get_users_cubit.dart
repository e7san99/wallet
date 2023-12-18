// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:wallet/feature/home/repository/get_users/get_users_repository.dart';
// import 'package:wallet/feature/register/repository/repository.dart';

// part 'get_users_state.dart';

// class GetUsersCubit extends Cubit<GetUsersState> {
//   GetUsersRepository getUsersRepository;
//   GetUsersCubit(this.getUsersRepository) : super(const GetUsersState());

//   Future<MyUser?> getSingleUser() async {
//     emit(state.copyWith(isLoading: true));
//     try {
//       final user = await getUsersRepository.getMyUser(FirebaseAuth.instance.currentUser?.uid);

//       if (user != null) {
//         emit(state.copyWith(isLoading: false, myUser: user));
//       } else {
//         emit(
//           state.copyWith(isLoading: false, error: '=== user is null ==='),
//         );
//       }
//     } catch (e) {
//       print("something went wrong $e");
//     }
//     return null;
//   }
// }

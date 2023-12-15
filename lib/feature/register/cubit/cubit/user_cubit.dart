import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wallet/feature/register/model/user.dart';
import 'package:wallet/feature/register/repository/auth_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.authRepository) : super(UserState());

  AuthRepository authRepository;
  // MyUser? myUser;

  Future<void> signup(
    String password,
    MyUser myUser,
  ) async {
    emit(state.copyWith(isLoading: true));
    final user = await authRepository.createUser(myUser, password);
    if (user != null) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          myUser: user,
        ),
      );
    } else if (user == null) {
      emit(state.copyWith(error: 'user is null'));
    }
  }

  Future<void> signin(String email, String password) async {
    emit(state.copyWith(isLoading: true));
    final user = await authRepository.signin(email, password);

    if (user != null) {
    
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          myUser: user,
        ),
      );
    } else {
      emit(state.copyWith(isLoading: false, error: 'User is null'));
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    emit(UserState());
   
  }

  Future<void> getUserData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final user = await authRepository
          .getMyUser(FirebaseAuth.instance.currentUser?.uid);

      if (user != null) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          myUser: user
        ));
      } else {
        emit(state.copyWith(error: 'User is null'));
      }
    } catch (e) {
      print('Error fetching user data: $e');
      emit(state.copyWith(error: 'Something went wrong'));
    }
  }
}

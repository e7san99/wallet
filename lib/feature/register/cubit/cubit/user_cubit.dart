import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wallet/feature/register/model/user.dart';
import 'package:wallet/feature/register/repository/auth_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.authRepository) : super( UserState());

  AuthRepository authRepository;
  //  MyUser? myUser;


  

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
          myUser: myUser,
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
    state.myUser = MyUser(
      username: state.myUser?.username,
      phone: state.myUser?.phone,
      email: email,
    );

    emit(
      state.copyWith(
        isLoading: false,
        isSuccess: true,
        myUser: state.myUser,
      ),
    );
  } else {
    emit(state.copyWith(isLoading: false, error: 'User is null'));
  }
}
  Future<void> logout() async {
    emit(state.copyWith(isLoading: true));
    await authRepository.logout();
    state.myUser = MyUser(
        username:state.myUser!.username, phone: state.myUser!.phone, email: state.myUser!.email);
    if (state.myUser != null) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        myUser: state.myUser,
      ));
    } else if (state.myUser == null) {
      emit(state.copyWith(error: 'user is null'));
    }
  }
}

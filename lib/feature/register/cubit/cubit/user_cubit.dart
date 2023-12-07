import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wallet/feature/register/model/user.dart';
import 'package:wallet/feature/register/repository/auth_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.authRepository) : super(const UserState());

  AuthRepository authRepository;

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
      state.copyWith(error: 'user is null');
    }
  }
}

import 'package:wallet/feature/register/cubit/cubit.dart';

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
          myUser: user,
        ),
      );
    } else if (user == null) {
      emit(state.copyWith(error: 'user is null'));
    }
  }

  Future<MyUser?> signin(String email, String password) async {
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
    return user;
  }

  Future<void> logout() async {
    await authRepository.logout();
    emit(const UserState());
  }

  Future<void> getUserData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final user = await authRepository
          .getMyUser(FirebaseAuth.instance.currentUser?.uid);

      if (user != null) {
        emit(state.copyWith(isLoading: false, isSuccess: true, myUser: user));
      } else {
        emit(state.copyWith(error: 'User is null'));
      }
    } catch (e) {
      print('Error fetching user data: $e');
      emit(state.copyWith(error: 'Something went wrong'));
    }
  }

  Future<void> getListOfUserData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final listOfUsers = await authRepository
          .getListOfMyUser();

      if (listOfUsers != null) {
        emit(state.copyWith(isLoading: false, isSuccess: true, listOfmyUser: listOfUsers));
      } else {
        emit(state.copyWith(error: 'User is null'));
      }
    } catch (e) {
      print('Error fetching user data: $e');
      emit(state.copyWith(error: 'Something went wrong'));
    }
  }
}

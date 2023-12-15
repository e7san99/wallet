part of 'user_cubit.dart';

class UserState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  MyUser? myUser;
  final String? error;

  UserState({
    this.isLoading = false,
    this.isSuccess = false,
    this.myUser,
    this.error,
  });

  UserState copyWith({
    bool? isLoading,
    bool? isSuccess,
    MyUser? myUser,
    String? error,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      myUser: myUser ?? this.myUser,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, error, myUser];
}

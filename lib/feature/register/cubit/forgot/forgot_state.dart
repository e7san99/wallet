part of 'forgot_cubit.dart';

class ForgotState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? email;
  const ForgotState({
    this.isLoading = false,
    this.isSuccess = false,
    this.email,
  });

  ForgotState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? email,
  }) {
    return ForgotState(
      isLoading: isLoading ?? this.isLoading,
      email: email ?? this.email,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess,email];
}

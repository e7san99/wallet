part of 'forgot_cubit.dart';

class ForgotState extends Equatable {
  final bool isLoading;
  final String? email;
  const ForgotState({
    this.isLoading = false,
    this.email,
  });

  ForgotState copyWith({
    bool? isLoading,
    String? email,
  }) {
    return ForgotState(
      isLoading: isLoading ?? this.isLoading,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [isLoading, email];
}

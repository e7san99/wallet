part of 'password_cubit.dart';

class PasswordState extends Equatable {
  final bool isVisible;
  const PasswordState({
    this.isVisible = false,
  });

  PasswordState copyWith({
    bool? isVisible,
  }) {
    return PasswordState(
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object?> get props => [isVisible];
}

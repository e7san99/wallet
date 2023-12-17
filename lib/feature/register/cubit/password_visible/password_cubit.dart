import 'package:wallet/feature/register/cubit/cubit.dart';

part 'password_state.dart';

class PasswordVisibleCubit extends Cubit<PasswordState> {
  PasswordVisibleCubit() : super(const PasswordState());

  void passwordVisible() {
    if (!state.isVisible) {
      emit(state.copyWith(isVisible: !state.isVisible));
    } else {
      emit(state.copyWith(isVisible: !state.isVisible));
    }
  }
}

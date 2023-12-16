import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(const PasswordState());

  void passwordVisible() {
    if (!state.isVisible) {
      emit(state.copyWith(isVisible:!state.isVisible));
    }else{
      emit(state.copyWith(isVisible: !state.isVisible));
    }
  }
}

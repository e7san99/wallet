import 'package:wallet/feature/register/cubit/cubit.dart';
part 'forgot_state.dart';

class ForgotCubit extends Cubit<ForgotState> {
  ForgotCubit(this.forgotRepository) : super(const ForgotState());
  ForgotRepository forgotRepository;

  Future<void> forgotAccount(String email) async{
    emit(state.copyWith(isLoading: true));
    await forgotRepository.forgotAccount(email);
    emit(
      state.copyWith(isLoading: false, email: email),
    );
  }
}

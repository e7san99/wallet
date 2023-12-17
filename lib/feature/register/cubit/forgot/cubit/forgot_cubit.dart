import 'package:wallet/feature/register/cubit/cubit.dart';
import 'package:wallet/feature/register/repository/repository.dart';
part 'forgot_state.dart';

class ForgotCubit extends Cubit<ForgotState> {
  ForgotCubit(this.forgotRepository) : super(const ForgotState());
  ForgotRepository forgotRepository;

  void forgotAccount(String email) async{
    emit(state.copyWith(isLoading: true));
    await forgotRepository.forgotAccount(email);
    emit(
      state.copyWith(isLoading: false, email: email),
    );
  }
}

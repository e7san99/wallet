import 'package:wallet/feature/home/home.dart';
import 'package:wallet/feature/home/repository/wallet/wallet_repository.dart';
import 'package:wallet/feature/register/view/view.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletRepository walletRepository;
  WalletCubit(this.walletRepository) : super(const WalletState());

  Future<void> getWallet() async {
    emit(state.copyWith(isLoading: true));

    final wallet = await walletRepository.getWallet();

    if (wallet != null) {
      emit(state.copyWith(wallet: wallet, isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false, error: 'I cry'));
    }
  }

  Future<void> addBalance(num balance) async {
    emit(state.copyWith(isLoading: true));
    final success = await walletRepository.updateBalance(balance);
    if (success) {
      getWallet();
    } else {
      emit(state.copyWith(isLoading: false, error: '=== wallet is null ==='));
    }
  }
}

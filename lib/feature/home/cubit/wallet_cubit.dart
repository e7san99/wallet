import 'dart:async';

import 'package:wallet/feature/home/home.dart';
import 'package:wallet/feature/home/repository/wallet/wallet_repository.dart';
import 'package:wallet/feature/register/view/view.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletRepository walletRepository;
  AuthRepository authRepository;
  StreamSubscription<Wallet?>? walletStreamSubscription;

  WalletCubit(this.walletRepository, this.authRepository)
      : super(const WalletState());

  Future<void> getWallet() async {
    emit(state.copyWith(isLoading: true));

    walletStreamSubscription?.cancel();

    walletStreamSubscription = walletRepository.getWallet().listen((wallet) {
      if (wallet != null) {
        emit(state.copyWith(wallet: wallet, isLoading: false));
      } else {
        emit(state.copyWith(
            isLoading: false, error: '=== get balance is null ==='));
      }
    });
  }

  Future<void> updateBalance(num balance) async {
    emit(state.copyWith(isLoading: true));
    balance += state.wallet!.balance ?? 0;
    final success = await walletRepository.updateBalance(balance);
    if (success) {
      getWallet();
    } else {
      emit(
        state.copyWith(
            isLoading: false, error: '=== update balance is null ==='),
      );
    }
  }

  Future<void> sendBalance(
      String currentUsername, num balance, String phone) async {
    emit(state.copyWith(isLoading: true));
    var sendBalance = state.wallet!.balance ?? 0;
    sendBalance = sendBalance - balance;

    final suc =
        await walletRepository.sendBalance(phone, currentUsername, balance);

    if (suc) {
      // No need to call getWallet() here, as the stream will automatically update the balance
      await walletRepository.updateBalance(sendBalance);
    } else {
      emit(
        state.copyWith(
            isLoading: false, error: '=== update balance is null ==='),
      );
    }
  }

  Future<bool> checkPhoneNumber(String phone) async {
    emit(state.copyWith(isLoading: true));
    try {
      final success = await walletRepository.checkPhoneNumber(phone);
      if (success) {
        emit(state.copyWith(isLoading: false));
        return true; // Phone number found
      } else {
        emit(state.copyWith(isLoading: false, error: 'idk idk idk'));
        return false; // Phone number not found
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'idk idk idk $e ======'));
      return false;
    }
  }

  Future<void> getTransaction() async {
    emit(state.copyWith(isLoading: true));
    try {
      final transaction = await walletRepository.getTransactions(
        state.transactionModel
            .map((e) => e.secondUsername.toString())
            .toString(),
      );
      if (transaction != null) {
        emit(
          state.copyWith(
            isLoading: false,
            transactionModel: transaction,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            error: 'something is wrong in getTransaction cubit',
          ),
        );
      }
    } catch (e) {
      print('wrong in getTransactions: $e');
      emit(
        state.copyWith(
          isLoading: false,
          error: 'something is wrong in getTransaction cubit',
        ),
      );
    }
  }
}

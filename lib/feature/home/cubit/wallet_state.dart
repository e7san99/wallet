part of 'wallet_cubit.dart';

class WalletState extends Equatable {
  final bool isLoading;
  final Wallet? wallet;
  final String? error;
  const WalletState({
    this.isLoading = false,
    this.wallet,
    this.error,
  });

  WalletState copyWith({
    bool? isLoading,
    Wallet? wallet,
    String? error,
  }) {
    return WalletState(
      isLoading: isLoading ?? this.isLoading,
      wallet: wallet ?? this.wallet,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, wallet, error];
}

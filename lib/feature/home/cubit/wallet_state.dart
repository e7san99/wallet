part of 'wallet_cubit.dart';

class WalletState extends Equatable {
  final bool isLoading;
  final Wallet? wallet;
  final String? error;
  final List<TransactionModel> transactionModel;
  const WalletState({
    this.isLoading = false,
    this.wallet,
    this.error,
    this.transactionModel = const [],
  });

  WalletState copyWith({
    bool? isLoading,
    Wallet? wallet,
    String? error,
    List<TransactionModel>? transactionModel,
  }) {
    return WalletState(
      isLoading: isLoading ?? this.isLoading,
      wallet: wallet ?? this.wallet,
      error: error ?? this.error,
      transactionModel: transactionModel ?? this.transactionModel,
    );
  }

  @override
  List<Object?> get props => [isLoading, wallet, error, transactionModel];

}

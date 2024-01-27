import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/view/view.dart';
import 'package:wallet/feature/register/cubit/cubit.dart';

class SendBalancePage extends StatefulWidget {
  const SendBalancePage({super.key});

  @override
  State<SendBalancePage> createState() => _SendBalancePageState();
}

class _SendBalancePageState extends State<SendBalancePage> {
  final formKey = GlobalKey<FormState>();
  String? balance;
  String? phone;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Send Balance'),
            centerTitle: true,
            backgroundColor: backgroundColor,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocSelector<WalletCubit, WalletState, num?>(
                  selector: (state) {
                    return state.wallet?.balance;
                  },
                  builder: (context, balance) {
                    return RichText(
                      text: TextSpan(
                        text: balance?.toString() ??
                            '0,00', //provider!.balance.toString()
                        style: TextStyle(
                          color: backgroundColor,
                          fontSize: 43,
                          fontWeight: FontWeight.w600,
                          height: 0.9,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' IQD',
                              style: TextStyle(
                                  fontSize: 20, color: backgroundColor)),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Total Amount',
                  style: TextStyle(
                    color: backgroundColor.withOpacity(0.8),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
                OwnTextFormField(
                  label: 'balance',
                  keyboardType: TextInputType.phone,
                  isNumber: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  icon: Icons.attach_money,
                  onSaved: (value) {
                    balance = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a balance';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                OwnTextFormField(
                  label: 'Phone',
                  keyboardType: TextInputType.phone,
                  isNumber: <TextInputFormatter>[phoneNumberFormatter],
                  icon: Icons.phone_outlined,
                  onSaved: (value) {
                    phone = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a phone';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocSelector<WalletCubit, WalletState, bool>(
                  selector: (state) {
                    return state.isLoading;
                  },
                  builder: (context, isLoading) {
                    return BlocSelector<UserCubit, UserState, String?>(
                      selector: (state) {
                        return state.myUser?.username;
                      },
                      builder: (context, state) {
                        return OwnButton(
                          textButton: Text(
                            'SEND',
                            style: TextStyle(
                              color: foregroundColor,
                              fontSize: 20,
                              fontFamily: 'lato',
                              letterSpacing: 1.2,
                            ),
                          ),
                          onPressed: isLoading
                              ? null
                              : () async {
                                
                                  
                                  
                                  formKey.currentState!.save();

                                  if (!formKey.currentState!.validate()) return;
                                  if (context
                                          .read<WalletCubit>()
                                          .state
                                          .wallet!
                                          .balance! <
                                      num.parse(balance!)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            'Your balance is less than send balance'),
                                      ),
                                    );
                                    return;
                                  }

                                  context.read<WalletCubit>().sendBalance(
                                        state ?? 'currentUsername',
                                        num.parse(balance!),
                                        phone ?? '000',
                                      );

                                  bool success = await context
                                      .read<WalletCubit>()
                                      .checkPhoneNumber(phone ?? '00');

                                  formKey.currentState!.reset();

                                  if (!mounted) {
                                    return;
                                  }
                                  
                                  if (!success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'This number ( $phone ) not exist'),
                                      ),
                                    );
                                  }
                                  print(
                                    "balance: ${num.parse(balance!)}",
                                  );
                                },
                          backgroundColor: backgroundColor,
                          foregroundColor: foregroundColor,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

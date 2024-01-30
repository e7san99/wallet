import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/home.dart';
import 'package:wallet/feature/home/repository/util/extention.dart';
import 'package:wallet/feature/home/view/view.dart';
import 'package:wallet/feature/register/view/view.dart';
import 'package:wallet/main/main_export.dart';

class AddBalancePage extends StatefulWidget {
  const AddBalancePage({super.key});

  @override
  State<AddBalancePage> createState() => _AddBalancePageState();
}

class _AddBalancePageState extends State<AddBalancePage> {
  final formKey = GlobalKey<FormState>();
  String? balance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Balance'),
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
                      text: balance?.currencyFormat(),
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
              Form(
                key: formKey,
                child: OwnTextFormField(
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
              ),
              const SizedBox(
                height: 10,
              ),
              BlocSelector<WalletCubit, WalletState, bool>(
                selector: (state) {
                  return state.isLoading;
                },
                builder: (context, state) {
                  return OwnButton(
                    textButton: Text(
                      'ADD',
                      style: TextStyle(
                        color: foregroundColor,
                        fontSize: 20,
                        fontFamily: 'lato',
                        letterSpacing: 1.2,
                      ),
                    ),
                    onPressed: state
                        ? null
                        : () {
                            if (!formKey.currentState!.validate()) return;
                            formKey.currentState!.save();
                            context
                                .read<WalletCubit>()
                                .updateBalance(num.parse(balance!));
                            print("balance: ${num.parse(balance!)}");
                          },
                    backgroundColor: backgroundColor,
                    foregroundColor: foregroundColor,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/home.dart';
import 'package:wallet/feature/home/util/extention.dart';
import 'package:wallet/feature/register/view/view.dart';
import 'package:wallet/main/main_export.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

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
                  isNumber: <TextInputFormatter>[ThousandsFormatter()],
                  icon: Icons.payments_outlined,
                  onSaved: (value) {
                    balance = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a balance';
                    }
                    // Remove commas before parsing
                    value = value.replaceAll(',', '');

                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return 'Enter a valid balance greater than 0';
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
                            // Remove commas before parsing
                            balance = balance!.replaceAll(',', '');
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.question,
                              animType: AnimType.leftSlide,
                              headerAnimationLoop: false,
                              showCloseIcon: true,
                              transitionAnimationDuration:
                                  const Duration(milliseconds: 100),
                              // descTextStyle: GoogleFonts.outfit(),
                              title: 'Add Balance',
                              body: Text.rich(
                                TextSpan(
                                  text: 'Are you sure to Add ',
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          '${num.parse(balance!).currencyFormat()} IQD',
                                      style: TextStyle(
                                          color: backgroundColor,
                                          fontWeight: FontWeight
                                              .bold), // Change color as needed
                                    ),
                                    const TextSpan(text: ' to your Balance ?'),
                                  ],
                                ),
                              ),
                              btnCancelText: 'No',
                              btnOkText: 'Yes',
                              btnCancelColor: Colors.red[700],
                              btnOkColor: Colors.green[700],

                              btnCancelOnPress: () {
                                return;
                              },
                              btnOkOnPress: () async {
                                context
                                    .read<WalletCubit>()
                                    .updateBalance(num.parse(balance!));
                                print("balance: ${num.parse(balance!)}");
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.scale,
                                  title: 'Successfully added',
                                  autoHide: const Duration(seconds: 3),
                                  btnOkColor: Colors.green,
                                  btnOkText: 'Done',
                                  btnOkOnPress: () {
                                    return;
                                  },
                                ).show();

                                formKey.currentState?.reset();
                              },
                            ).show();
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

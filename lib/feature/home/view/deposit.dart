import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/home.dart';
import 'package:wallet/feature/home/util/extention.dart';
import 'package:wallet/feature/home/widget/dialog/custom_dialog.dart';
import 'package:wallet/feature/home/widget/dialog/custom_dialog_timer.dart';
import 'package:wallet/feature/register/view/view.dart';
import 'package:wallet/main/main_export.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
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
          title: Text(
            'Deposit',
            style: GoogleFonts.openSans(
              color: foregroundColor,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
          ),
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
                      style: GoogleFonts.openSans(
                        color: backgroundColor,
                        fontSize: 43,
                        fontWeight: FontWeight.w600,
                        height: 0.9,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' IQD',
                            style: GoogleFonts.openSans(
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
                style: GoogleFonts.openSans(
                  color: backgroundColor.withOpacity(0.8),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
              Form(
                key: formKey,
                child: OwnTextFormField(
                  maxLength: 9,
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
                    // if (double.tryParse(value) == null ||
                    //     double.parse(value) < 1000) {
                    //   return 'The minimum balance is 1,000';
                    // }
                    if (double.tryParse(value) == null ||
                        double.parse(value) > 1000000) {
                      return 'The maximum balance is 1,000,000';
                    }

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
                      style: GoogleFonts.openSans(
                        color: foregroundColor,
                        fontSize: 20,
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
                            showDialog(
                              context: context,
                              builder: (customDialogcontext) =>
                                  CustomeDialogWidget(
                                title: 'Deposit',
                                content1: 'Are you sure to Add ',
                                content2:
                                    '${num.parse(balance!).currencyFormat()} IQD',
                                content2Style: GoogleFonts.openSans(
                                  color: backgroundColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                content3: ' to your Balance ?',
                                image: 'deposit',
                                titleStyle: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  color:
                                      backgroundColor, //const Color(0xffEC5B5B),
                                  fontWeight: FontWeight.bold,
                                ),
                                noButton: () {
                                  Navigator.pop(customDialogcontext);
                                },
                                yesButton: () {
                                  context
                                      .read<WalletCubit>()
                                      .updateBalance(num.parse(balance!));
                                  Navigator.pop(context);
                                  formKey.currentState?.reset();
                                  print("balance: ${num.parse(balance!)}");
                                  // Future.delayed(Duration.zero, () {
                                  showDialog(
                                      context: context,
                                      builder: (customDialogTimercontext) =>
                                          CustomDialogTimer(
                                            seconds: 3,
                                            image: 'tick',
                                            content1: 'Successfully added',
                                            okButton: () {
                                              Navigator.pop(
                                                  customDialogTimercontext);
                                            },
                                          ));
                                  // });
                                },
                              ),
                            );
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

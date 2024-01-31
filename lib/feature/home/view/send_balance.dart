import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/repository/util/extention.dart';
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
                    if (double.parse(value) <= 0) {
                      return 'Enter a balance greater than 0';
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
                                  // Show the loading dialog only if the login is successful
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Container(
                                          width: 10, // Set your desired width
                                          height: 40, // Set your desired height
                                          decoration: const BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 1, sigmaY: 1),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                LoadingAnimationWidget
                                                    .dotsTriangle(
                                                  color: backgroundColor,
                                                  size: 50,
                                                ),
                                                const SizedBox(width: 20),
                                                DefaultTextStyle(
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontFamily: 'Agne',
                                                    color: backgroundColor,
                                                  ),
                                                  child: AnimatedTextKit(
                                                    animatedTexts: [
                                                      TypewriterAnimatedText(
                                                        'Loading...',
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    barrierDismissible: false,
                                  );
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

                                  bool success = await context
                                      .read<WalletCubit>()
                                      .checkPhoneNumber(phone ?? '00');
                                  if (!mounted) {
                                    return;
                                  }
                                  Navigator.pop(
                                      context); // Close loading dialog

                                  if (!success) {
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.scale,
                                      dialogType: DialogType.warning,
                                      dialogBackgroundColor: Colors.yellow,
                                      isDense: true,
                                      body: Center(
                                        child: Text(
                                          "This number ( $phone ) not exist",
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      btnOkOnPress: () {},
                                    ).show();
                                  } else {
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
                                          text: 'Are you sure to Send ',
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  '${num.parse(balance!).currencyFormat()} IQD',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight
                                                      .bold), // Change color as needed
                                            ),
                                            const TextSpan(
                                                text:
                                                    ' \nfor this phone number'),
                                            TextSpan(
                                              text: ' $phone ',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const TextSpan(text: '?'),
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
                                        context.read<WalletCubit>().sendBalance(
                                              state ?? 'currentUsername',
                                              num.parse(balance!),
                                              phone ?? '000',
                                            );
                                        print(
                                          "balance: ${num.parse(balance!)}",
                                        );

                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.success,
                                          animType: AnimType.scale,
                                          title: 'Balance sent successfully',
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
                                  }
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

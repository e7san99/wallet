import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/util/extention.dart';
import 'package:wallet/feature/home/view/view.dart';
import 'package:wallet/feature/home/widget/dialog/custom_dialog.dart';
import 'package:wallet/feature/home/widget/dialog/custom_dialog_timer.dart';
import 'package:wallet/feature/register/cubit/cubit.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

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
                    } else if (!value.startsWith('07') || value.length < 13) {
                      return 'Enter valid number';
                    }
                    return null;
                  },
                  // maxLength: 11,
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

                                  // Remove commas before parsing
                                  balance = balance!.replaceAll(',', '');

                                  if (phone ==
                                      context
                                          .read<UserCubit>()
                                          .state
                                          .myUser
                                          ?.phone) {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.scale,
                                      title:
                                          'You can\'t send balance to yourself',
                                      headerAnimationLoop: false,

                                      // title: 'Balance sent successfully',
                                      // autoHide: const Duration(seconds: 3),
                                      btnOkColor:
                                          const Color.fromRGBO(217, 62, 71, 1),
                                      btnOkText: 'Done',
                                      btnOkOnPress: () {
                                        return;
                                      },
                                    ).show();
                                    return;
                                  }
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

                                  bool success = await context
                                      .read<WalletCubit>()
                                      .checkPhoneNumber(phone ?? '00');
                                  if (!mounted) {
                                    return;
                                  }

                                  Navigator.pop(
                                      context); // Close loading dialog

                                  if (context
                                          .read<WalletCubit>()
                                          .state
                                          .wallet!
                                          .balance! <
                                      num.parse(balance!)) {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.scale,
                                      title: 'You don\'t have enough balance',
                                      headerAnimationLoop: false,

                                      // title: 'Balance sent successfully',
                                      // autoHide: const Duration(seconds: 3),
                                      btnOkColor:
                                          const Color.fromRGBO(217, 62, 71, 1),
                                      btnOkText: 'Done',
                                      btnOkOnPress: () {
                                        return;
                                      },
                                    ).show();

                                    return;
                                  }

                                  if (!success) {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.scale,
                                      body: Text.rich(
                                        TextSpan(
                                          text: 'This phone number ',
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '$phone',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight
                                                      .bold), // Change color as needed
                                            ),
                                            const TextSpan(
                                                text: ' is not exist'),
                                          ],
                                        ),
                                      ),
                                      // title: 'Balance sent successfully',
                                      autoHide: const Duration(seconds: 3),
                                      btnOkColor:
                                          const Color.fromRGBO(254, 184, 0, 1),
                                      btnOkText: 'Done',
                                      btnOkOnPress: () {
                                        return;
                                      },
                                    ).show();
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (customDialogcontext) =>
                                          CustomeDialogWidget(
                                        title: 'Send Balance',
                                        content1: 'Are you sure to Send ',
                                        content2:
                                            '${num.parse(balance!).currencyFormat()} IQD',
                                        content2Style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                        content3: ' \nfor this phone number',
                                        content4: ' $phone ',
                                        content5: '?',
                                        image: 'question',
                                        titleStyle: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          color:
                                              backgroundColor, //const Color(0xffEC5B5B),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        noButton: () {
                                          Navigator.pop(customDialogcontext);
                                        },
                                        yesButton: () async {
                                          context
                                              .read<WalletCubit>()
                                              .sendBalance(
                                                state ?? 'currentUsername',
                                                num.parse(balance!),
                                                phone ?? '000',
                                              );
                                          Navigator.pop(context);
                                          formKey.currentState?.reset();
                                          print(
                                            "balance: ${num.parse(balance!)}",
                                          );

                                          showDialog(
                                              context: context,
                                              builder:
                                                  (customDialogTimercontext) =>
                                                      CustomDialogTimer(
                                                        title: '',
                                                        image: 'tick',
                                                        titleStyle: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 20,
                                                          color:
                                                              backgroundColor, //const Color(0xffEC5B5B),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        content:
                                                            'Balance sent successfully',
                                                        okButton: () {
                                                          Navigator.pop(
                                                              customDialogTimercontext);
                                                        },
                                                      ));
                                        },
                                      ),
                                    );
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

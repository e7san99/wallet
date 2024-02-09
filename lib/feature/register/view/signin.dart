// import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wallet/feature/home/widget/dialog/custom_dialog.dart';

import 'package:wallet/feature/register/view/view.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listenWhen: (previous, current) {
        return previous.myUser != current.myUser;
      },
      listener: (context, state) {
        if (state.myUser != null) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('Login'),
          //   ),
          // );

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
        }
      },
      child: Form(
        key: formKey,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              leading: const SizedBox(),
              backgroundColor: backgroundColor,
              elevation: 0,
            ),
            backgroundColor: backgroundColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Image.asset(
                //   height: 70,
                //   'assets/images/logo.png',
                //   color: foregroundColor,
                //   scale: 1,
                // ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'BluePay',
                    style: GoogleFonts.openSans(
                      color: foregroundColor,
                      fontSize: 28,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height, //* 0.6,
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                'Welcome Back !',
                                style: GoogleFonts.openSans(
                                  color: backgroundColor.withOpacity(0.6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              OwnTextFormField(
                                label: 'Email',
                                keyboardType: TextInputType.emailAddress,
                                isNumber: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ],
                                icon: Icons.email_outlined,
                                onSaved: (value) {
                                  email = value;
                                },
                                validator: (value) {
                                  const pattern =
                                      r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                                  final regExp = RegExp(pattern);
                                  if (value!.isEmpty) {
                                    return 'Enter an email';
                                  } else if (!regExp.hasMatch(value)) {
                                    return 'Enter a valid email';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              BlocSelector<PasswordVisibleCubit, PasswordState,
                                  bool>(
                                selector: (state) {
                                  return state.isVisible;
                                },
                                builder: (context, isVisible) {
                                  return OwnPasswordFormField(
                                    icon: Icon(
                                      !isVisible
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility,
                                    ),
                                    onPressedIcon: () {
                                      context
                                          .read<PasswordVisibleCubit>()
                                          .passwordVisible();
                                    },
                                    onSaved: (value) {
                                      password = value;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter a Password';
                                      } else if (value.length < 6) {
                                        return 'more than 6 characters';
                                      } else {
                                        return null;
                                      }
                                    },
                                    obscureText: !isVisible,
                                  );
                                },
                              ),
                              Align(
                                alignment: Alignment.topRight * 0.7,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotAccount(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Forgot password?',
                                    style: GoogleFonts.openSans(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              BlocSelector<UserCubit, UserState, bool>(
                                selector: (state) {
                                  return state.isLoading;
                                },
                                builder: (context, state) {
                                  return OwnButton(
                                    textButton: Text(
                                      'SIGN IN',
                                      style: GoogleFonts.openSans(
                                        color: foregroundColor,
                                        fontSize: 20,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    onPressed: state
                                        ? null
                                        : () async {
                                            // showDialog(
                                            //   context: context,
                                            //   builder: (context) =>
                                            //       const CustomeDialogWidget(),
                                            // );
                                            final valid = formKey.currentState!
                                                .validate();
                                            if (valid) {
                                              formKey.currentState!.save();

                                              // Show the loading dialog only if the login is successful
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: Container(
                                                      width:
                                                          10, // Set your desired width
                                                      height:
                                                          40, // Set your desired height
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      child: BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                                sigmaX: 1,
                                                                sigmaY: 1),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            LoadingAnimationWidget
                                                                .dotsTriangle(
                                                              color:
                                                                  backgroundColor,
                                                              size: 50,
                                                            ),
                                                            const SizedBox(
                                                                width: 20),
                                                            DefaultTextStyle(
                                                              style: GoogleFonts
                                                                  .openSans(
                                                                fontSize: 18.0,
                                                                color:
                                                                    backgroundColor,
                                                              ),
                                                              child:
                                                                  AnimatedTextKit(
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
                                              final user = await context
                                                  .read<UserCubit>()
                                                  .signin(email!, password!);

                                              if (!mounted) {
                                                return;
                                              }
                                              Navigator.pop(
                                                  context); // Close the loading dialog

                                              HapticFeedback.heavyImpact();

                                              if (user == null) {
                                                if (!mounted) {
                                                  return;
                                                }
                                                showTopSnackBar(
                                                  Overlay.of(context),
                                                  const CustomSnackBar.error(
                                                    message:
                                                        "Email or Password is incorrect",
                                                  ),
                                                );
                                                return;
                                              }
                                            }
                                          },
                                    backgroundColor: backgroundColor,
                                    foregroundColor: foregroundColor,
                                  );
                                },
                              ),
                              AleardyHadAccount(
                                title: 'Don\'t have an account? ',
                                buttonTitle: 'Sign up',
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignupPage(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

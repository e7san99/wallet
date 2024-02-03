import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/register/view/view.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  String? username;
  String? phone;
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
          //     content: Text('Success'),
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
              iconTheme: IconThemeData(color: foregroundColor),
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
                    style: TextStyle(
                      color: foregroundColor,
                      fontFamily: 'title',
                      fontSize: 28,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
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
                                'Create an account',
                                style: TextStyle(
                                  color: backgroundColor.withOpacity(0.6),
                                  fontFamily: 'lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              OwnTextFormField(
                                label: 'Full Name',
                                keyboardType: TextInputType.name,
                                isNumber: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ],
                                icon: Icons.person_outline,
                                onSaved: (value) {
                                  username = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter a name';
                                  }
                                  return null;
                                },
                              ),
                              OwnTextFormField(
                                label: 'Phone',
                                keyboardType: TextInputType.phone,
                                isNumber: <TextInputFormatter>[
                                  phoneNumberFormatter
                                ],
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
                              BlocSelector<UserCubit, UserState, bool>(
                                selector: (state) {
                                  return state.isLoading;
                                },
                                builder: (context, state) {
                                  return OwnButton(
                                    textButton: Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                        color: foregroundColor,
                                        fontSize: 20,
                                        fontFamily: 'lato',
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    onPressed: state
                                        ? null
                                        : () async {
                                            final valid = formKey.currentState!
                                                .validate();
                                            if (valid) {
                                              formKey.currentState!.save();

                                              // Check if the phone number is unique before proceeding
                                              bool isUnique = await context
                                                  .read<WalletCubit>()
                                                  .checkPhoneNumber(phone!);
                                              if (!mounted) {
                                                return;
                                              }
                                              if (isUnique) {
                                                showTopSnackBar(
                                                  Overlay.of(context),
                                                  const CustomSnackBar.error(
                                                    message:
                                                        'The phone number is already registered',
                                                  ),
                                                );
                                                return;
                                              }
                                              ////////////////////

                                              // Check if the Email is unique before proceeding
                                              bool isUniqueEmail = await context
                                                  .read<UserCubit>()
                                                  .checkAlreadyEmail(email!);
                                              if (!mounted) {
                                                return;
                                              }
                                              if (isUniqueEmail) {
                                                showTopSnackBar(
                                                  Overlay.of(context),
                                                  const CustomSnackBar.error(
                                                    message:
                                                        'The email is already registered',
                                                  ),
                                                );

                                                return;
                                              }
                                              ////////////////////

                                              // Show the loading dialog only if the login is successful
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
                                                              style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontFamily:
                                                                    'Agne',
                                                                color:
                                                                    backgroundColor,
                                                              ),
                                                              child:
                                                                  AnimatedTextKit(
                                                                animatedTexts: [
                                                                  TypewriterAnimatedText(
                                                                      'Loading...'),
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
                                              await context
                                                  .read<UserCubit>()
                                                  .signup(
                                                    password!,
                                                    MyUser(
                                                      username: username,
                                                      phone: phone,
                                                      email: email,
                                                    ),
                                                  );
                                              // Close the loading dialog
                                              if (!mounted) {
                                                return;
                                              }
                                              Navigator.pop(context);

                                              HapticFeedback.heavyImpact();
                                            }
                                          },
                                    backgroundColor: backgroundColor,
                                    foregroundColor: foregroundColor,
                                  );
                                },
                              ),
                              AleardyHadAccount(
                                title: 'Already have an account? ',
                                buttonTitle: 'Sign in',
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SigninPage(),
                                      ),
                                      (route) => false);
                                },
                              )
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
/*

Email Validator

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

*/

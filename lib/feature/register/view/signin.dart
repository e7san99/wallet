// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/components/reusable/already_had_account.dart';
import 'package:wallet/components/reusable/button.dart';
import 'package:wallet/components/reusable/password.dart';
import 'package:wallet/components/reusable/textfield.dart';
import 'package:wallet/components/theme/theme.dart';
import 'package:wallet/feature/home/view/home_page.dart';
import 'package:wallet/feature/register/cubit/password/password_cubit.dart';
import 'package:wallet/feature/register/cubit/user/user_cubit.dart';
import 'package:wallet/feature/register/view/signup.dart';

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
        // if (state.myUser == null){
        //       ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: Text('this email not registered'),
        //     ),
        //   );
        // }
        // else
        if (state.myUser != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login in'),
            ),
          );
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
        }
      },
      child: Form(
        key: formKey,
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
                  style: TextStyle(
                    color: foregroundColor,
                    fontFamily: 'title',
                    fontSize: 28,
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
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
                              style: TextStyle(
                                color: backgroundColor.withOpacity(0.6),
                                fontFamily: 'lato',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            OwnTextFormField(
                              label: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              isNumber: <TextInputFormatter>[
                                FilteringTextInputFormatter.singleLineFormatter,
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
                            BlocSelector<PasswordCubit, PasswordState, bool>(
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
                                        .read<PasswordCubit>()
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
                                onPressed: () {},
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'lato',
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
                                          final valid =
                                              formKey.currentState!.validate();
                                          if (valid) {
                                            formKey.currentState!.save();

                                            final user = await context
                                                .read<UserCubit>()
                                                .signin(email!, password!);
                                            if (user == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    'email or password is incorrect',
                                                    style: TextStyle(
                                                      color: foregroundColor,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                  backgroundColor: backgroundColor,
                                  foregroundColor: foregroundColor,
                                );
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, bottom: 15),
                              child: Text(
                                '━━━━━━━━━━━━━ OR ━━━━━━━━━━━━━',
                                style: TextStyle(
                                  color: backgroundColor,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(25)),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Image.asset(
                                  //   height: 30,
                                  //   'assets/images/g.png',
                                  //   //color: foregroundColor,
                                  //   scale: 1,
                                  // ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Sign in with Google',
                                        style: TextStyle(
                                          color: foregroundColor,
                                          fontSize: 18,
                                          fontFamily: 'lato',
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            AleardyHadAccount(
                              title: 'Don\'t have an account? ',
                              buttonTitle: 'Sign up',
                              onTap: () {
                                Navigator.push(
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
    );
  }
}

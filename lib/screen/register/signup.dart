import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/components/reusable/already_had_account.dart';
import 'package:wallet/components/reusable/button.dart';
import 'package:wallet/components/reusable/password.dart';
import 'package:wallet/components/reusable/textfield.dart';
import 'package:wallet/components/theme/theme.dart';

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
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
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
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            icon: Icons.person_outline,
                            onSaved: (value) {
                              setState(() {
                                username = value;
                              });
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
                            keyboardType: TextInputType.number,
                            isNumber: const <TextInputFormatter>[
                              /////////////////////////////////////////// <<del    phoneNumberFormatter
                            ],
                            icon: Icons.phone_outlined,
                            onSaved: (value) {
                              setState(() {
                                phone = value;
                              });
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
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            icon: Icons.email_outlined,
                            onSaved: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter an email';
                              }
                              return null;
                            },
                          ),
                          OwnPasswordFormField(
                            icon: const Icon(Icons.visibility_off_outlined),
                            onPressedIcon: () {},
                            onSaved: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Pnter a password';
                              }
                              return null;
                            },
                            obscureText: true,
                          ),
                          OwnButton(
                            textButton: Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: foregroundColor,
                                fontSize: 20,
                                fontFamily: 'lato',
                                letterSpacing: 1.2,
                              ),
                            ),
                            onPressed: () async {
                              final valid = formKey.currentState!.validate();
                              if (valid) {
                                formKey.currentState!.save();
                                ////you will write down below
                              }
                            },
                            backgroundColor: backgroundColor,
                            foregroundColor: foregroundColor,
                          ),
                          AleardyHadAccount(
                            title: 'Already have an account? ',
                            buttonTitle: 'Sign in',
                            onTap: () {
                              // Navigator.pushAndRemoveUntil(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => const SignInPage(),
                              //     ),
                              //     (route) => false);
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
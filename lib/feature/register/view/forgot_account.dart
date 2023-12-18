// ignore_for_file: use_build_context_synchronously

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wallet/feature/register/view/view.dart';

class ForgotAccount extends StatefulWidget {
  const ForgotAccount({super.key});

  @override
  State<ForgotAccount> createState() => _ForgotAccountState();
}

class _ForgotAccountState extends State<ForgotAccount> {
  final formKey = GlobalKey<FormState>();
  String? email;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
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
                            'Recovery Page',
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
                          BlocSelector<ForgotCubit, ForgotState, bool>(
                            selector: (state) {
                              return state.isLoading;
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
                                onPressed: state
                                    ? null
                                    : () async{
                                        final valid =
                                            formKey.currentState!.validate();
                                        if (valid) {
                                          formKey.currentState!.save();
                                          try {
                                            await context
                                                .read<ForgotCubit>()
                                                .forgotAccount(email!);
                                                
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text('check your email'),
                                              ),
                                            );
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text('maynera bra'),
                                              ),
                                            );
                                          }
                                          
                                            

//                                             showTopSnackBar(
//                                                 Overlay.of(context),
//                                                 const CustomSnackBar.success(
//                                                   message: '''Check Your inbox
// We sent you a verification email''',
//                                                 ),
//                                               );
                                        
                                        }
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

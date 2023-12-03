import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/components/reusable/button.dart';
import 'package:wallet/components/reusable/phone_format.dart';
import 'package:wallet/components/reusable/textfield.dart';
import 'package:wallet/components/theme/theme.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Balance'),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: '25,000', //provider!.balance.toString()
                style: TextStyle(
                  color: backgroundColor,
                  fontSize: 43,
                  fontWeight: FontWeight.w600,
                  height: 0.9,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: ' IQD',
                      style: TextStyle(fontSize: 20, color: backgroundColor)),
                ],
              ),
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
                setState(() {
                  balance = value;
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter a balance';
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
            const SizedBox(
              height: 10,
            ),
            OwnButton(
              textButton: Text(
                'SEND',
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 20,
                  fontFamily: 'lato',
                  letterSpacing: 1.2,
                ),
              ),
              onPressed: () {},
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wallet/feature/home/view/home_page.dart';
import 'package:wallet/feature/home/view/send_balance.dart';
import 'package:wallet/feature/register/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BluePay',
      home: SendBalancePage()
    );
  }
}

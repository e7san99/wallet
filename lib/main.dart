import 'package:flutter/material.dart';
import 'package:wallet/screen/home.dart';
import 'package:wallet/screen/register/signin.dart';
import 'package:wallet/screen/register/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallet',
      home: HomePage(),
    );
  }
}

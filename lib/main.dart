import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/feature/home/view/home_page.dart';
import 'package:wallet/feature/home/view/send_balance.dart';
import 'package:wallet/feature/register/cubit/cubit/user_cubit.dart';
import 'package:wallet/feature/register/repository/auth_implement.dart';
import 'package:wallet/feature/register/view/signin.dart';
import 'package:wallet/feature/register/view/signup.dart';
import 'package:wallet/feature/register/view/start_page.dart';
import 'package:wallet/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(
            AuthImplement(),
          ),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BluePay',
        home: StartPage(),
      ),
    );
  }
}

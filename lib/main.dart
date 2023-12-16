import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/feature/register/cubit/password/password_cubit.dart';
import 'package:wallet/feature/register/cubit/user/user_cubit.dart';
import 'package:wallet/feature/register/repository/auth_implement.dart';
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
        ),
        BlocProvider(
          create: (context) => PasswordCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BluePay',
        home: StartPage(),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:wallet/feature/register/cubit/forgot/cubit/forgot_cubit.dart';
import 'package:wallet/feature/register/repository/forgot/forgot_implement.dart';
import 'package:wallet/feature/register/view/forgot.dart';
import 'package:wallet/firebase_options.dart';
import 'package:wallet/feature/register/register.dart';

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
          create: (context) => PasswordVisibleCubit(),
        ),
        BlocProvider(
          create: (context) => ForgotCubit(
            ForgotImplement(),
          ),
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

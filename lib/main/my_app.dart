import 'package:wallet/feature/home/cubit/user/cubit/get_users_cubit.dart';
import 'package:wallet/feature/home/repository/get_users/get_users_implement.dart';
import 'package:wallet/main/main_export.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => GetUsersCubit(GetUsersImplement()),
        // ),
        BlocProvider(
          create: (context) => UserCubit(AuthImplement()),
        ),
        BlocProvider(create: (context) => PasswordVisibleCubit()),
        BlocProvider(
          create: (context) => ForgotCubit(ForgotImplement()),
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

import 'package:wallet/feature/home/cubit/bloc/internet_bloc.dart';
import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/repository/wallet/wallet_implement.dart';
import 'package:wallet/feature/register/widget/go_router.dart';
import 'package:wallet/main/main_export.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(AuthImplement()),
        ),
        BlocProvider(create: (context) => PasswordVisibleCubit()),
        BlocProvider(
          create: (context) => ForgotCubit(ForgotImplement()),
        ),
        BlocProvider(
          create: (context) => WalletCubit(WalletImplement(), AuthImplement()),
        ),
        BlocProvider(
          create: (context) => InternetBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
        ),
        title: 'BluePay',
        routerConfig: router,
      ),
    );
  }
}

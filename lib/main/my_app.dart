import 'package:go_router/go_router.dart';
import 'package:wallet/feature/home/cubit/bloc/internet_bloc.dart';
import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/home.dart';
import 'package:wallet/feature/home/repository/wallet/wallet_implement.dart';
import 'package:wallet/feature/home/view/transactions.dart';
import 'package:wallet/main/main_export.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// The route configuration.
    final GoRouter router = GoRouter(
      initialLocation: '/startPage',
      routes: [
        GoRoute(
          path: '/startPage',
          builder: (context, state) => const StartPage(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/signin',
          builder: (context, state) => const SigninPage(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignupPage(),
        ),
        GoRoute(
          path: '/forgot',
          builder: (context, state) => const SignupPage(),
        ),
        GoRoute(
          path: '/deposit',
          builder: (context, state) => const DepositPage(),
        ),
        GoRoute(
          path: '/sendBalance',
          builder: (context, state) => const SendBalancePage(),
        ),
        GoRoute(
          path: '/transaction',
          builder: (context, state) => const TransactionsPage(),
        ),
      ],
    );
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

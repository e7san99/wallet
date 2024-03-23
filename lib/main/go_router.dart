import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/feature/home/home.dart';
import 'package:wallet/feature/home/view/transactions.dart';

import '../feature/register/view/view.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  // redirect: (context, state) {
  //   final Connectivity connectivity = Connectivity();
  //   connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
  //     // Handle connectivity changes here
  //     // Example:
  //     if (result == ConnectivityResult.none) {
  //       // No internet connection

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('No internet')),
  //       );

  //       GoRouter.of(context).go('/forgot');

  //       return;
  //     } else if (result == ConnectivityResult.mobile ||
  //         result == ConnectivityResult.wifi) {
  //       return;
  //     }
  //   });
  //   return null;
  // },
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
    import 'package:go_router/go_router.dart';
import 'package:wallet/feature/home/view/deposit.dart';
import 'package:wallet/feature/home/view/send_balance.dart';
import 'package:wallet/feature/home/view/transactions.dart';

import '../view/view.dart';

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
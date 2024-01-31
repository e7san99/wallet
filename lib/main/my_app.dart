import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/repository/wallet/wallet_implement.dart';
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
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: false,
          ),
          title: 'BluePay',
          home: const StartPage(),
          ),
    );
  }
}

// BlocConsumer<InternetBloc, InternetState>(
//           builder: (context, state) {
//             if (state is InternetNotConnectedState) {
//               return Center(
//                 child: Text(state.message),
//               );
//             } else if (state is InternetConnectedState) {
//               return Center(child: Text(state.message));
//             } else {
//               return const SizedBox();
//             }
//           },
//           listener: (BuildContext context, Object? state) {
//             // if (state is InternetConnectedState) {
//             //   Fluttertoast.showToast(msg: 'back to Online');
//             // } else
//             if (state is InternetNotConnectedState) {
//               Fluttertoast.showToast(msg: 'Not Internet Connection');
//             }
//           },
//         ));

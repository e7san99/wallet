// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:wallet/feature/home/view/home_page.dart';
// import 'package:wallet/feature/register/view/signin.dart';
// import 'package:wallet/feature/register/view/signup.dart';

// class AuthPage extends StatelessWidget {
//   const AuthPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return const HomePage();
//           } else {
//             return const SignupPage();
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wallet/feature/register/view/view.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    _redirect();
    super.initState();
  }

  Future _redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final user = firebaseAuth.currentUser;
    if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SigninPage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }

    // if (user != null) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const HomePage(),
    //     ),
    //   );
    // }
    // {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const SigninPage(),
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: LoadingAnimationWidget.dotsTriangle(
        color: Colors.red,
        size: 50,
      ),
      // child: const Center(
      //   child: CircularProgressIndicator(
      //     color: Colors.red,
      //   ),
    );
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
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


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: foregroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingAnimationWidget.dotsTriangle(
              color: backgroundColor,
              size: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  textStyle:  TextStyle(color: backgroundColor, fontSize: 16),
                  'Loading...',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
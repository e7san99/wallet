import 'dart:async';

import 'package:wallet/feature/home/home.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialogTimer extends StatefulWidget {
  final int seconds;
  final String? image, content1, content2, content3;
    final Color? content2Color;
  final void Function()? okButton;

  const CustomDialogTimer({
    super.key,
    required this.image,
    required this.content1,
    this.content2,
    this.content3,
    this.content2Color,
    required this.okButton,
    required this.seconds,
  });

  @override
  State<CustomDialogTimer> createState() => _CustomDialogTimerState();
}

class _CustomDialogTimerState extends State<CustomDialogTimer> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer
    _startTimer();
  }

  @override
  void dispose() {
    // Dispose of the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    // Start a 3-second timer
    _timer = Timer(Duration(seconds: widget.seconds), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Timer(const Duration(seconds: 3), () {
    //   Navigator.pop(context);
    // });
    return Dialog(
      backgroundColor: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: foregroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            CardDialog(
              image: widget.image,
              content1: widget.content1,
              content2: widget.content2,
              content3: widget.content3,
              content2Color: widget.content2Color,
              okButton: widget.okButton,
            ),
            Positioned(
              top: 0,
              right: -15,
              height: 28,
              width: 60,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  shape: const CircleBorder(),
                  backgroundColor: const Color(0xffEC5B5B),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/img/dialog/close.png',
                  // width: 72,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardDialog extends StatelessWidget {
  final String? image, content1, content2, content3;
  final Color? content2Color;
  final void Function()? okButton;
  const CardDialog({
    super.key,
    required this.image,
    required this.content1,
    this.content2,
    this.content3,
    this.content2Color,
    required this.okButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 16,
      ),
      margin: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: foregroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingScaleUp(
              // rotation: 50,
              delay: const Duration(milliseconds: 250),
              // curve: const ElasticInOutCurve(),
            ),
            child: Image.asset(
              'assets/img/dialog/$image.png',
              width: 72,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          // Text(
          //   title,
          //   style: titleStyle,
          //   //  GoogleFonts.montserrat(
          //   //   fontSize: 24,
          //   //   color: const Color(0xffEC5B5B),
          //   //   fontWeight: FontWeight.bold,
          //   // ),
          // ),
          const SizedBox(
            height: 4,
          ),
          Text.rich(
            TextSpan(
              text: content1, //'Are you sure to Add ',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: content2,
                  style: GoogleFonts.poppins(
                      color: content2Color, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: content3, //'Are you sure to Add ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 32,
          ),

          Center(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 30,
                ),
                foregroundColor: backgroundColor,
                side: BorderSide(
                  color: backgroundColor,
                ),
              ),
              onPressed: okButton,
              child: const Text('OK'),
            ),
          ),
        ],
      ),
    );
  }
}

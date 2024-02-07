import 'dart:async';

import 'package:wallet/feature/home/home.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:google_fonts/google_fonts.dart';

// class CustomDialog extends StatefulWidget {
//   const CustomDialog({super.key});

//   @override
//   State<CustomDialog> createState() => _CustomDialogState();
// }

// class _CustomDialogState extends State<CustomDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: ElevatedButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) => const CustomeDialogWidget(),
//                 );
//               },
//               child: const Text('pop up'))),
//     );
//   }
// }

class CustomeDialogWidget extends StatelessWidget {
    final String title, content, image;
  final TextStyle titleStyle, contentStyle;
  const CustomeDialogWidget({super.key, required this.title, required this.content, required this.image, required this.titleStyle, required this.contentStyle});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pop(context);
    });
    return Dialog(
      backgroundColor: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: foregroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
           CardDialog(title: title, content: content, image: image, titleStyle: titleStyle, contentStyle: contentStyle),
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
            )
          ],
        ),
      ),
    );
  }
}

class CardDialog extends StatelessWidget {
  final String title, content, image;
  final TextStyle titleStyle, contentStyle;
  const CardDialog({
    super.key,
    required this.title,
    required this.content,
    required this.image, required this.titleStyle, required this.contentStyle,
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
          Text(
            title,
            style:titleStyle,
          //    GoogleFonts.montserrat(
          //     fontSize: 24,
          //     color: const Color(0xffEC5B5B),
          //     fontWeight: FontWeight.bold,
          //   ),
           ),
          const SizedBox(
            height: 4,
          ),
          Text(
            content, 
            style: contentStyle,
            //'more text you write in here okay\nyou can say what happened !',
            // style: GoogleFonts.poppins(
            //   color: Colors.red,
            //   fontWeight: FontWeight.w300,
            // ),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 20,
                  ),
                  foregroundColor: const Color(0xffEC5B5B),
                  side: const BorderSide(
                    color: Color(0xffEC5B5B),
                  ),
                ),
                onPressed: () {},
                child: const Text('Cancel'),
              ),
              const SizedBox(
                width: 15,
              ),
              OutlinedButton(
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
                onPressed: () {},
                child: const Text('Yes'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

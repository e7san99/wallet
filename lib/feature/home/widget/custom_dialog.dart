import 'package:wallet/feature/home/home.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

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
  const CustomeDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: foregroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            const CardDialog(),
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
  const CardDialog({
    super.key,
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
              'assets/img/dialog/info.png',
              width: 72,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Alter',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'more text you write in here okay\nyou can say what happened !',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
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

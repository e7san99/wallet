import 'package:flutter/material.dart';
import 'package:wallet/components/theme/theme.dart';

class AleardyHadAccount extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final void Function()? onTap;

  const AleardyHadAccount(
      {super.key,
      required this.title,
      required this.buttonTitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: backgroundColor.withOpacity(0.8),
              fontFamily: 'lato',
              fontSize: 16,
            ),
          ),
          TextButton(
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(
                EdgeInsets.all(0),
              ),
            ),
            onPressed: onTap,
            child: Text(
              buttonTitle,
              style: TextStyle(
                color: backgroundColor,
                fontFamily: 'lato',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

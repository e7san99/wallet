import 'package:flutter/material.dart';

class OwnButton extends StatelessWidget {
  final Widget textButton;
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  const OwnButton({
    super.key,
    required this.textButton,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextButton(
          onPressed: onPressed,
          child: textButton,
        ),
      ),
    );
  }
}

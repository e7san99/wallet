import 'package:flutter/material.dart';
import 'package:wallet/components/theme/theme.dart';

class OwnPasswordFormField extends StatefulWidget {
  final Icon icon;
  final void Function()? onPressedIcon;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool obscureText;
  const OwnPasswordFormField({
    Key? key,

    required this.icon,
    required this.onPressedIcon,
    required this.onSaved,
    required this.validator,
    required this.obscureText,
  }) : super(key: key);

  @override
  State<OwnPasswordFormField> createState() => _OwnPasswordFormFieldState();
}

class _OwnPasswordFormFieldState extends State<OwnPasswordFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextFormField(
        autocorrect: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(
          color: backgroundColor, //range nusene naw textfieldakaya
          fontFamily: 'lato',
        ),
        keyboardType: TextInputType.name,
        onSaved: widget.onSaved,
        validator: widget.validator,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          label: Text(
            'Password',
            style: TextStyle(
                color: backgroundColor.withOpacity(0.6), fontFamily: 'lato'),
          ),
          suffixIcon: IconButton(
            onPressed: widget.onPressedIcon,
            icon:widget.icon,
            color: backgroundColor.withOpacity(0.7),
          ),
          // suffixIconColor: backgroundColor,
          counterStyle: const TextStyle(color: Colors.red),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: backgroundColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: backgroundColor,
            ),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/components/theme/theme.dart';

class OwnTextFormField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? isNumber;
  final IconData icon;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final int? maxLength;
  const OwnTextFormField({
    super.key,
    required this.label,
    required this.keyboardType,
    required this.isNumber,
    required this.icon,
    required this.onSaved,
    required this.validator,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextFormField(
        maxLength: maxLength,
        autocorrect: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(
          color: backgroundColor, //range nusene naw textfieldakaya
          fontFamily: 'lato',
        ),
        keyboardType: keyboardType,
        inputFormatters: isNumber,
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          counterStyle: TextStyle(color: backgroundColor),
          label: Text(
            label,
            style: TextStyle(
              color: backgroundColor.withOpacity(0.6),
              fontFamily: 'lato',
              fontSize: 14,
            ),
          ),
          suffixIcon: Icon(
            icon,
            color: backgroundColor.withOpacity(0.7),
          ),
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

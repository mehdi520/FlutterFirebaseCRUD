import 'package:flutter/material.dart';
import 'package:my_books_app/core/app_colors/app_color.dart';

class PrimaryTextFormField extends StatelessWidget {
  final String hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final TextInputAction? imeAction;
  final TextInputType? keyboardType;
  final bool? isSecureTextField;
  final String? Function(String?)? validator;
  final TextEditingController ctrl;

  const PrimaryTextFormField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.imeAction,
    this.keyboardType,
    this.isSecureTextField,
    this.validator,
    required this.ctrl
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: imeAction ?? TextInputAction.done,
      obscureText: isSecureTextField != null ? isSecureTextField! : false,

      validator: validator,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,

        filled: false,
        border:  const OutlineInputBorder(
            borderSide:BorderSide(color:AppColors.primary,width: 2)
        ),
        enabledBorder:  const OutlineInputBorder(
            borderSide:BorderSide(color:AppColors.primary,width: 2)

        ),
        focusedBorder:  const OutlineInputBorder(
            borderSide:BorderSide(color:AppColors.primary,width: 2)

        ),
      ),
    );
  }
}


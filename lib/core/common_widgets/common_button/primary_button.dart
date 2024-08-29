
import 'package:flutter/material.dart';
import 'package:my_books_app/core/app_colors/app_color.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final String? Function() onTap;

  const PrimaryButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {

          return _initialButton();

  }

  Widget _initialButton() {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primary,
            border: Border.all(
              color: AppColors.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: AppColors.white),
            ),
          )),
    );
  }

  Widget _loadingButton() {
    return InkWell(
      onTap: null,
      child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primary,
            border: Border.all(
              color: AppColors.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: const CircularProgressIndicator(

            ),
          )),
    );
  }
}

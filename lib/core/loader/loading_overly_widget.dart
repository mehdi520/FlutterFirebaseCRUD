import 'package:flutter/material.dart';
import 'package:my_books_app/core/app_colors/app_color.dart';

class LoadingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(
          child: CircularProgressIndicator( color: AppColors.primary,),
        ),
      ],
    );
  }
}

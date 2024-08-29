import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_books_app/core/common_widgets/text/gradient_text.dart';
import 'package:my_books_app/core/navigator/app_navigator.dart';
import 'package:my_books_app/data/model/common/resp/base_response_model.dart';
import 'package:my_books_app/data/repository/user/user_repository_impl.dart';
import 'package:my_books_app/domain/user/user_repository.dart';
import 'package:my_books_app/presentation/home/home_screen.dart';
import 'package:my_books_app/presentation/pub/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final UserRepository userRepository = UserRepositoryImpl();

  void naviagetApp(bool isloggedIn, BuildContext context) {
    Timer(Duration(seconds: 3), ()
    {
      if (isloggedIn) {
        AppNavigator.pushReplacement(context, HomeScreen());
      } else {
        AppNavigator.pushReplacement(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userRepository.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (snapshot.data!.success) {
                naviagetApp(true, context);
              } else {
                naviagetApp(false, context);
              }
            });
          }
          return Scaffold(
            body: Center(
              child: Container(child: GradientText(text: "Book App")),
            ),
          );
        });
  }
}

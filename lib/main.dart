import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_books_app/core/app_theme/app_theme.dart';
import 'package:my_books_app/presentation/pub/login/login_screen.dart';

import 'firebase_options.dart';
import 'presentation/pub/splash/spalsh_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        home: SplashScreen()
    );
  }
}



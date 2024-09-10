import 'package:flutter/material.dart';
import 'package:sample/SplashScreen.dart';
import 'package:sample/features/authentication/screens/login/login.dart';
import 'app.dart';

/// ----- entry point of the flutter app ----
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
     debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}


import 'dart:async';
import 'package:fade_out_particle/fade_out_particle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sample/features/authentication/screens/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1000000000),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'lib/Assets/splashScreenLottie.json', // Replace with the path to your Lottie JSON file
                fit: BoxFit.cover,
                width: 400, // Adjust the width and height as needed
                height: 400,
                repeat: false, // Set to true if you want the animation to loop
              ),
            ),
            const Center(
              child: FadeOutParticle(
                disappear: true,
                duration: Duration(seconds: 5),
                child: Text('Fade out Particle',
                style: TextStyle(fontSize: 30,color: Colors.red),),
              )
            )
          ],
        ),
      ),
    );
  }
}
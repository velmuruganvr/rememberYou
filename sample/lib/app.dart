import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Your demo Title'),
        ),
        body: const Center(
          child: Text(
            'Hello, World!',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black, // Set text color to red
            ),
          ),
        ),
      ),
    );
  }

}
import 'package:sight_companion/audiobook/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const Audioapp());
}

class Audioapp extends StatelessWidget {
  const Audioapp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Color.fromARGB(255, 255, 255, 255)),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sight_companion/views/main_page.dart';
import 'package:provider/provider.dart';
import 'package:sight_companion/models/models.dart';

void main() {
  runApp(const MyAppProviders());
}

const bool demo = false;

class MyAppProviders extends StatelessWidget {
  const MyAppProviders({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<InputState>(create: (context) => InputState()),
        ChangeNotifierProvider<GameState>(create: (context) => GameState()),
        ChangeNotifierProvider<AppOptionsState>(
            create: (context) => AppOptionsState()),
      ],
      child: const MyBraileeApp(),
    );
  }
}

class MyBraileeApp extends StatelessWidget {
  const MyBraileeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Braille Typing Game",
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(0xffdddddd)),
      themeMode: Provider.of<AppOptionsState>(context).getTheme(),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

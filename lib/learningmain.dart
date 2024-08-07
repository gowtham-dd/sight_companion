import 'package:flutter/material.dart';
import 'package:sight_companion/cores/cores.dart';
import 'package:sight_companion/routes/app_router.dart';

void main() {
  runApp(const Learningmain());
}

class Learningmain extends StatelessWidget {
  const Learningmain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'enlive',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.router,
    );
  }
}

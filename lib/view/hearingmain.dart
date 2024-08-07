import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sight_companion/binder/dashboard_bindings.dart';
import 'package:sight_companion/view/dashboard.dart';

void main() {
  runApp(const Hearingmain());
}

class Hearingmain extends StatelessWidget {
  const Hearingmain({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: Dashboard(),
      initialBinding: TranslateBindings(),
    );
  }
}

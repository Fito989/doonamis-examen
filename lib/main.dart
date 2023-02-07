import 'package:doonamis_examen/modules/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() => runApp(ModularApp(module: AppModule(), child: DoonamisApp()));

class DoonamisApp extends StatelessWidget {
  const DoonamisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      debugShowCheckedModeBanner: false,
      title: 'Doonamis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

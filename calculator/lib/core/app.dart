import 'package:calculator/view/calculator_view.dart';
import 'package:calculator/theme/theme_data.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        routes: const {
          // '/area': (context) => const AreaOfCircle(),
        },
        home: const CalculatorApp());
  }
}

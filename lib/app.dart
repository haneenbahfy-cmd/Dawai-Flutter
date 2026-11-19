import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'core/app_data.dart';

class DawaiApp extends StatelessWidget {
  const DawaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dawa'i - دوائي",
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: C.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: C.purple),
      ),
      home: const SplashScreen(),
    );
  }
}

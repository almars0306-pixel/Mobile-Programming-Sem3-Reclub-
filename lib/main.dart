import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'tampilan_utama/tampilan_utama.dart';

void main() {
  runApp(const MyApp());
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      scrollBehavior: AppScrollBehavior(),
      theme: ThemeData(
        // seed warna disamain sama warna brand Reclub biar konsisten
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B2FE0),
        ),
      ),
      home: const OnboardingPage(),
    );
  }
}
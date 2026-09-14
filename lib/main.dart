import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'tampilan_utama/tampilan_utama.dart';

void main() {
  runApp(const MyApp());
}

// Supaya PageView / ListView bisa di-swipe pakai mouse drag juga
// (default Flutter cuma dengar touch, jadi di Chrome kerasa "gabisa di-swipe").
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginPage(),
    );
  }
}
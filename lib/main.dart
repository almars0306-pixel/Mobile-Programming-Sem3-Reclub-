import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import 'features/home/event_controller.dart';
import 'features/home/notif_controller.dart';
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
    return MultiProvider(
      providers: [
        // Satu sumber data untuk seluruh app (state management).
        // Sekalian ambil data yang tersimpan di storage saat app dibuka.
        ChangeNotifierProvider(
          create: (_) => EventController()..muatDariStorage(),
        ),
        // Data notifikasi juga lewat provider supaya titik merah di
        // beranda dan halaman notifikasi selalu sinkron.
        ChangeNotifierProvider(create: (_) => NotifController()),
      ],
      child: MaterialApp(
        title: 'Reclub',
        debugShowCheckedModeBanner: false,
        scrollBehavior: AppScrollBehavior(),
        theme: ThemeData(
          // seed warna disamain sama warna brand Reclub biar konsisten
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF3B2FE0),
          ),
        ),
        home: const OnboardingPage(),
      ),
    );
  }
}

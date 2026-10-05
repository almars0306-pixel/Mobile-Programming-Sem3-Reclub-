import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application/features/home/event_controller.dart';
import 'package:flutter_application/features/home/home_page.dart';

void main() {
  // HomePage memakai shared_preferences buat kategori dan
  // EventController dari provider, jadi disiapkan dulu di tiap test.
  Future<void> pumpBeranda(
    WidgetTester tester, {
    VoidCallback? onOpenEvents,
    EventController? controller,
  }) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: controller ?? EventController(),
        child: MaterialApp(home: HomePage(onOpenEvents: onOpenEvents ?? () {})),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('menampilkan sapaan dan event default', (tester) async {
    await pumpBeranda(tester);

    expect(find.text('Halo, Reclubber!'), findsOneWidget);
    expect(find.text('EVENT LARI'), findsOneWidget);
    expect(find.text('Untar Futsal Club'), findsOneWidget);
  });

  testWidgets('Lihat semua memanggil onOpenEvents', (tester) async {
    var dibuka = 0;
    await pumpBeranda(tester, onOpenEvents: () => dibuka++);

    await tester.tap(find.text('Lihat semua'));
    expect(dibuka, 1);
  });

  testWidgets('filter kategori menyembunyikan event yang tidak cocok',
      (tester) async {
    await pumpBeranda(tester);

    // Event default kategori Lari. Pilih chip "Futsal" -> tidak ada
    // event yang cocok, muncul empty state.
    await tester.tap(find.text('Futsal'));
    await tester.pumpAndSettle();

    expect(find.text('EVENT LARI'), findsNothing);
    expect(find.text('Event tidak ditemukan'), findsOneWidget);
  });

  testWidgets('beranda ikut berubah saat event controller diperbarui',
      (tester) async {
    final controller = EventController();
    await pumpBeranda(tester, controller: controller);

    expect(find.text('EVENT LARI'), findsOneWidget);

    controller.setEvents([
      {
        'title': 'Bareng Basket',
        'location': 'Lapangan Kampus',
        'date': '2 Des 2026',
        'icon': Icons.sports_basketball,
        'description': 'Basket 3v3',
        'creator_id': 'user_akbar',
      },
    ]);
    await tester.pumpAndSettle();

    expect(find.text('EVENT LARI'), findsNothing);
    expect(find.text('Bareng Basket'), findsOneWidget);
  });
}

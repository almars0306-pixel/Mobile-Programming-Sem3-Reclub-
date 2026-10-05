import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application/features/home/event_controller.dart';
import 'package:flutter_application/features/home/home_page.dart';
import 'package:flutter_application/features/home/notif_controller.dart';

void main() {
  // HomePage memakai shared_preferences buat kategori dan
  // EventController + NotifController dari provider,
  // jadi disiapkan dulu di tiap test.
  Future<void> pumpBeranda(
    WidgetTester tester, {
    VoidCallback? onOpenEvents,
    VoidCallback? onOpenClub,
    EventController? controller,
    NotifController? notifController,
  }) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: controller ?? EventController()),
          ChangeNotifierProvider.value(
              value: notifController ?? NotifController()),
        ],
        child: MaterialApp(
          home: HomePage(
            onOpenEvents: onOpenEvents ?? () {},
            onOpenClub: onOpenClub ?? () {},
          ),
        ),
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

  testWidgets('Lihat semua event memanggil onOpenEvents', (tester) async {
    var dibuka = 0;
    await pumpBeranda(tester, onOpenEvents: () => dibuka++);

    await tester.tap(find.text('Lihat semua').first);
    expect(dibuka, 1);
  });

  testWidgets('Lihat semua club memanggil onOpenClub', (tester) async {
    var dibuka = 0;
    await pumpBeranda(tester, onOpenClub: () => dibuka++);

    await tester.tap(find.text('Lihat semua').last);
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

  testWidgets('pencarian menyaring club juga', (tester) async {
    await pumpBeranda(tester);

    await tester.enterText(find.byType(TextField), 'runners');
    await tester.pumpAndSettle();

    expect(find.text('Jakarta Runners'), findsOneWidget);
    expect(find.text('Untar Futsal Club'), findsNothing);
    expect(
      find.text('Tidak ada club yang cocok dengan pencarian'),
      findsNothing,
    );
  });

  testWidgets('pencarian tanpa hasil club menampilkan info', (tester) async {
    await pumpBeranda(tester);

    await tester.enterText(find.byType(TextField), 'zumba');
    await tester.pumpAndSettle();

    expect(
      find.text('Tidak ada club yang cocok dengan pencarian'),
      findsOneWidget,
    );
  });

  testWidgets('titik merah hilang setelah semua notifikasi dibaca',
      (tester) async {
    final notif = NotifController();
    await pumpBeranda(tester, notifController: notif);

    // Ada notifikasi belum dibaca -> titik merah tampil.
    expect(notif.belumDibaca, greaterThan(0));
    expect(find.byKey(const ValueKey('notif_dot')), findsOneWidget);

    // Tandai semua dibaca -> titik merah ikut hilang otomatis (provider).
    notif.tandaiSemuaDibaca();
    await tester.pumpAndSettle();

    expect(notif.belumDibaca, 0);
    expect(find.byKey(const ValueKey('notif_dot')), findsNothing);
  });

  testWidgets('beranda ikut berubah saat event controller diperbarui',
      (tester) async {
    final controller = EventController();
    await pumpBeranda(tester, controller: controller);

    expect(find.text('EVENT LARI'), findsOneWidget);

    await controller.setEvents([
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

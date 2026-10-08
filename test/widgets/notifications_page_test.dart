import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/features/home/notif_controller.dart';
import 'package:flutter_application/features/home/notifications_page.dart';

void main() {
  Future<void> pumpNotifikasi(
    WidgetTester tester, {
    NotifController? controller,
  }) async {
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: controller ?? NotifController(),
        child: const MaterialApp(home: NotificationsPage()),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('menampilkan semua notifikasi', (tester) async {
    await pumpNotifikasi(tester);

    expect(find.text('Notifikasi'), findsOneWidget);
    expect(find.text('Selamat datang di Reclub!'), findsOneWidget);
    expect(find.text('Tandai dibaca'), findsOneWidget);
  });

  testWidgets('ketuk tile menandai satu notifikasi dibaca', (tester) async {
    final controller = NotifController();
    await pumpNotifikasi(tester, controller: controller);

    expect(controller.belumDibaca, 2);
    await tester.tap(find.text('EVENT LARI besok sore!'));
    await tester.pumpAndSettle();

    expect(controller.belumDibaca, 1);
  });

  testWidgets('tombol Tandai dibaca menghabiskan semua notifikasi',
      (tester) async {
    final controller = NotifController();
    await pumpNotifikasi(tester, controller: controller);

    await tester.tap(find.text('Tandai dibaca'));
    await tester.pumpAndSettle();

    expect(controller.belumDibaca, 0);
  });

  testWidgets('list kosong menampilkan pesan sudah dibaca', (tester) async {
    final controller = NotifController(notifikasiAwal: const []);
    await pumpNotifikasi(tester, controller: controller);

    expect(find.text('Semua notifikasi sudah dibaca'), findsOneWidget);
    expect(find.text('Tandai dibaca'), findsNothing);
  });
}

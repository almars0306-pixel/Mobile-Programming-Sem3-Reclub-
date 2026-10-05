import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application/features/home/widgets/event_card.dart';

void main() {
  testWidgets('menampilkan judul, lokasi, dan tanggal event', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EventCard(
            title: 'EVENT LARI',
            location: 'Gelora Bung Karno',
            date: '24 Sep 2026',
            icon: Icons.directions_run,
          ),
        ),
      ),
    );

    expect(find.text('EVENT LARI'), findsOneWidget);
    expect(find.text('Gelora Bung Karno'), findsOneWidget);
    expect(find.text('24 Sep 2026'), findsOneWidget);
  });

  testWidgets('tap kartu event memanggil onTap', (tester) async {
    var diketuk = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventCard(
            title: 'Bareng Futsal',
            location: 'GOR',
            date: '30 Nov 2026',
            icon: Icons.sports_soccer,
            onTap: () => diketuk++,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Bareng Futsal'));
    expect(diketuk, 1);
  });
}

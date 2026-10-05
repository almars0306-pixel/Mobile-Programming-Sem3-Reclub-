import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application/features/home/widgets/section_header.dart';

void main() {
  testWidgets('menampilkan judul section', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SectionHeader(title: 'Event Minggu Ini')),
      ),
    );

    expect(find.text('Event Minggu Ini'), findsOneWidget);
    // tanpa callback, tombol "Lihat semua" tidak muncul
    expect(find.text('Lihat semua'), findsNothing);
  });

  testWidgets('tombol Lihat semua memanggil callback', (tester) async {
    var dipanggil = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SectionHeader(
            title: 'Club Populer',
            onSeeAll: () => dipanggil++,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Lihat semua'));
    expect(dipanggil, 1);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application/features/home/widgets/club_card.dart';

void main() {
  testWidgets('menampilkan nama club dan jumlah anggota', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ClubCard(
            name: 'Untar Futsal Club',
            members: 128,
            icon: Icons.sports_soccer_rounded,
          ),
        ),
      ),
    );

    expect(find.text('Untar Futsal Club'), findsOneWidget);
    expect(find.text('128 anggota'), findsOneWidget);
    expect(find.text('Lihat'), findsOneWidget);
  });

  testWidgets('tap kartu club memanggil onTap', (tester) async {
    var diketuk = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [
              ClubCard(
                name: 'Jakarta Runners',
                members: 340,
                icon: Icons.directions_run_rounded,
                onTap: () => diketuk++,
              ),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.text('Jakarta Runners'));
    expect(diketuk, 1);
  });
}

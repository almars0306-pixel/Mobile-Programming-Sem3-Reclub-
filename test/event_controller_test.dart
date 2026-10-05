import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application/features/home/event_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('EventController', () {
    test('mulai dengan daftar event default', () {
      final controller = EventController();
      expect(controller.events.length, 1);
      expect(controller.events.first['title'], 'EVENT LARI');
    });

    test('setEvents mengganti daftar dan memberi tahu listener', () {
      final controller = EventController();
      var notified = false;
      controller.addListener(() => notified = true);

      controller.setEvents([
        {
          'title': 'Futsal Malam',
          'location': 'GOR Untar',
          'date': '1 Des 2026',
          'icon': Icons.sports_soccer,
          'description': 'Futsal santai',
          'creator_id': 'user_akbar',
        },
      ]);

      expect(notified, isTrue);
      expect(controller.events.first['title'], 'Futsal Malam');
    });

    test('event tersimpan ke storage dan bisa dimuat ulang', () async {
      SharedPreferences.setMockInitialValues({});
      final controller = EventController();
      // Tunggu sampai data benar-benar tersimpan sebelum dibaca ulang.
      await controller.setEvents([
        {
          'title': 'Badminton Sore',
          'location': 'Lapangan Kampus',
          'date': '10 Des 2026',
          'icon': Icons.sports_tennis,
          'description': 'Doubles santai',
          'creator_id': 'user_akbar',
        },
      ]);

      // Controller baru meniru app dibuka ulang: harus kebaca dari storage.
      final controllerBaru = EventController();
      await controllerBaru.muatDariStorage();

      expect(controllerBaru.events.length, 1);
      expect(controllerBaru.events.first['title'], 'Badminton Sore');
      // Ikon harus kembali jadi const Icons yang sama (round-trip nama).
      expect(controllerBaru.events.first['icon'], Icons.sports_tennis);
    });

    test('storage kosong tetap pakai default event', () async {
      SharedPreferences.setMockInitialValues({});
      final controller = EventController();
      await controller.muatDariStorage();
      expect(controller.events.first['title'], 'EVENT LARI');
    });
  });

  group('IkonEvent', () {
    test('dariNama mengembalikan ikon yang benar', () {
      expect(IkonEvent.dariNama('sports_soccer'), Icons.sports_soccer);
      expect(IkonEvent.dariNama('directions_run'), Icons.directions_run);
    });

    test('dariNama pakai fallback kalau nama tidak dikenal', () {
      expect(IkonEvent.dariNama('tidak_ada'), Icons.event);
      expect(IkonEvent.dariNama(null), Icons.event);
    });

    test('namaDariIcon bolak-balik dengan dariNama', () {
      for (final entry in IkonEvent.daftar.entries) {
        expect(IkonEvent.dariNama(entry.key), entry.value);
        expect(IkonEvent.namaDariIcon(entry.value), entry.key);
      }
    });
  });
}

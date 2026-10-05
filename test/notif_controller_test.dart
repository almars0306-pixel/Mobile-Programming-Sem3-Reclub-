import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application/features/home/notif_controller.dart';

void main() {
  group('NotifController', () {
    test('mulai dengan notifikasi belum dibaca', () {
      final controller = NotifController();
      expect(controller.belumDibaca, 2);
      expect(controller.daftar.length, 4);
    });

    test('tandaiDibaca mengurangi jumlah belum dibaca dan memberi tahu listener',
        () {
      final controller = NotifController();
      var notified = false;
      controller.addListener(() => notified = true);

      controller.tandaiDibaca(0);

      expect(notified, isTrue);
      expect(controller.belumDibaca, 1);
      expect(controller.daftar.first.dibaca, isTrue);
    });

    test('tandaiDibaca pada yang sudah dibaca tidak melakukan apa-apa', () {
      final controller = NotifController();
      var notified = false;
      controller.addListener(() => notified = true);

      // index 2 sudah dibaca sejak awal
      controller.tandaiDibaca(2);

      expect(notified, isFalse);
      expect(controller.belumDibaca, 2);
    });

    test('tandaiSemuaDibaca membuat belum dibaca jadi nol', () {
      final controller = NotifController();
      controller.tandaiSemuaDibaca();

      expect(controller.belumDibaca, 0);
      expect(controller.daftar.every((n) => n.dibaca), isTrue);
    });

    test('daftar tidak bisa diubah dari luar', () {
      final controller = NotifController();
      expect(() => controller.daftar.clear(), throwsUnsupportedError);
    });
  });
}

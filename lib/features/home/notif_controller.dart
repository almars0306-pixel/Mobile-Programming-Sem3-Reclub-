import 'package:flutter/material.dart';

/// Satu item notifikasi.
class Notifikasi {
  final String judul;
  final String isi;
  final IconData ikon;
  final String waktu;
  final bool dibaca;

  const Notifikasi({
    required this.judul,
    required this.isi,
    required this.ikon,
    required this.waktu,
    this.dibaca = false,
  });

  Notifikasi copyWith({bool? dibaca}) {
    return Notifikasi(
      judul: judul,
      isi: isi,
      ikon: ikon,
      waktu: waktu,
      dibaca: dibaca ?? this.dibaca,
    );
  }
}

/// Pusat data notifikasi (pola ChangeNotifier, sama seperti EventController).
///
/// Datanya masih contoh (dummy). Kalau nanti project lanjut ke backend,
/// tinggal ganti sumber datanya — halaman yang menampilkan notifikasi
/// tidak perlu diubah karena sudah lewat provider.
class NotifController extends ChangeNotifier {
  /// Data contoh (dummy). Kalau nanti project lanjut ke backend,
  /// tinggal ganti sumber datanya — halaman yang menampilkan
  /// notifikasi tidak perlu diubah karena sudah lewat provider.
  static const List<Notifikasi> _contohData = [
    Notifikasi(
      judul: 'EVENT LARI besok sore!',
      isi: 'Jangan lupa ikut lari santai di Gelora Bung Karno, ya.',
      ikon: Icons.directions_run_rounded,
      waktu: '10 menit lalu',
    ),
    Notifikasi(
      judul: 'Untar Futsal Club buka pendaftaran',
      isi: 'Anggota baru ditahun ini dapat diskon lapangan 20%.',
      ikon: Icons.sports_soccer_rounded,
      waktu: '2 jam lalu',
    ),
    Notifikasi(
      judul: 'Badminton Sore dibatalkan',
      isi: 'Lapangan dipoles ulang, event dijadwalkan ulang pekan depan.',
      ikon: Icons.sports_tennis_rounded,
      waktu: '1 hari lalu',
      dibaca: true,
    ),
    Notifikasi(
      judul: 'Selamat datang di Reclub!',
      isi: 'Cari event olahraga dan club favoritmu di sekitar kampus.',
      ikon: Icons.celebration_rounded,
      waktu: '3 hari lalu',
      dibaca: true,
    ),
  ];

  final List<Notifikasi> _daftar;

  /// [notifikasiAwal] boleh diisi data lain (dipakai test, atau nanti
  /// data dari backend). Kalau tidak diisi, pakai data contoh.
  /// List.of biar salinannya bisa diubah (list const asli immutable).
  NotifController({List<Notifikasi>? notifikasiAwal})
      : _daftar = List.of(notifikasiAwal ?? _contohData);

  /// Daftar notifikasi (tidak bisa diubah langsung dari luar).
  List<Notifikasi> get daftar => List.unmodifiable(_daftar);

  /// Jumlah notifikasi yang belum dibaca.
  /// Dipakai ikon lonceng di beranda buat nampilin titik merah.
  int get belumDibaca => _daftar.where((n) => !n.dibaca).length;

  /// Tandai satu notifikasi sudah dibaca (dipanggil saat tile-nya diketuk).
  void tandaiDibaca(int index) {
    if (index < 0 || index >= _daftar.length || _daftar[index].dibaca) return;
    _daftar[index] = _daftar[index].copyWith(dibaca: true);
    notifyListeners();
  }

  /// Tandai semua notifikasi sudah dibaca.
  void tandaiSemuaDibaca() {
    if (belumDibaca == 0) return;
    for (var i = 0; i < _daftar.length; i++) {
      _daftar[i] = _daftar[i].copyWith(dibaca: true);
    }
    notifyListeners();
  }
}

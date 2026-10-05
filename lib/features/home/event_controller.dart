import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Pusat data event aplikasi Reclub.
///
/// Ini pakai pola ChangeNotifier (state management bawaan Flutter):
/// - Halaman apa pun bisa baca daftar event lewat provider.
/// - Kalau ada perubahan (tambah/hapus event), semua halaman
///   yang sedang menampilkan event otomatis ikut diperbarui.
/// - Setiap perubahan langsung disimpan ke storage device pakai
///   shared_preferences, jadi event tidak hilang saat app ditutup.
class EventController extends ChangeNotifier {
  /// Key penyimpanan di shared_preferences.
  static const String _storageKey = 'reclub_events';

  /// Event bawaan yang muncul saat pertama kali buka app.
  /// Kalau user sudah pernah menambah/menghapus event, data tersimpan
  /// yang akan dipakai.
  static List<Map<String, dynamic>> get _defaultEvents => [
        {
          'title': 'EVENT LARI',
          'location': 'Gelora Bung Karno',
          'date': '24 Sep 2026',
          'icon': Icons.directions_run,
          'description':
              'Lari santai sore hari bareng komunitas. Terbuka untuk umum!',
          'creator_id': 'user_lain', // milik orang lain, tidak bisa dihapus
        },
      ];

  List<Map<String, dynamic>> _events = _defaultEvents;

  /// Daftar event yang sedang ada. Jangan diubah langsung dari luar,
  /// gunakan [setEvents] supaya tersimpan dan UI ikut ter-update.
  List<Map<String, dynamic>> get events => _events;

  /// Ganti isi daftar event (dipakai saat menambah / menghapus).
  ///
  /// [newEvents] dipakai sebagai daftar baru, semua yang mendengarkan
  /// perubahan ini otomatis rebuild, lalu datanya disimpan ke storage.
  /// Mengembalikan Future yang selesai setelah data benar-benar tersimpan
  /// (UI boleh tidak menunggu, tapi test menggunakannya untuk memastikan).
  Future<void> setEvents(List<Map<String, dynamic>> newEvents) async {
    _events = newEvents;
    notifyListeners();
    await _simpanKeStorage();
  }

  /// Ambil data event yang tersimpan di storage saat app dibuka.
  ///
  /// Kalau belum ada data tersimpan (pertama kali pakai app),
  /// daftar default yang dipakai.
  Future<void> muatDariStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? json = prefs.getString(_storageKey);
      if (json == null) return; // belum ada data, pakai default

      final List<dynamic> decoded = jsonDecode(json) as List<dynamic>;
      final List<Map<String, dynamic>> hasil = decoded
          .map((item) => _fromJson(item as Map<String, dynamic>))
          .toList();

      _events = hasil;
      notifyListeners();
    } catch (e) {
      // Data rusak / format salah: abaikan, tetap pakai default.
      debugPrint('Gagal memuat event dari storage: $e');
    }
  }

  /// Ubah event jadi bentuk yang bisa disimpan.
  /// Ikon disimpan sebagai nama string, bukan angka, biar mudah
  /// dibaca dan tidak bermasalah dengan icon tree-shaking.
  Map<String, dynamic> _toJson(Map<String, dynamic> event) {
    return {
      'title': event['title'],
      'location': event['location'],
      'date': event['date'],
      'description': event['description'],
      'icon': IkonEvent.namaDariIcon(event['icon']),
      'creator_id': event['creator_id'],
    };
  }

  /// Kembalikan event dari data yang tersimpan.
  Map<String, dynamic> _fromJson(Map<String, dynamic> json) {
    return {
      'title': json['title'],
      'location': json['location'],
      'date': json['date'],
      'description': json['description'],
      'icon': IkonEvent.dariNama(json['icon']),
      'creator_id': json['creator_id'],
    };
  }

  Future<void> _simpanKeStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String json = jsonEncode(_events.map(_toJson).toList());
      await prefs.setString(_storageKey, json);
    } catch (e) {
      debugPrint('Gagal menyimpan event ke storage: $e');
    }
  }
}

/// Daftar ikon yang bisa dipakai event + helper ubah nama <-> IconData.
///
/// Ikon di app harus tetap berupa konstanta Icons (bukan IconData buatan
/// dari angka codePoint) supaya icon tree-shaking release build tetap jalan.
class IkonEvent {
  IkonEvent._();

  static const Map<String, IconData> daftar = {
    'local_activity': Icons.local_activity,
    'directions_run': Icons.directions_run,
    'sports_esports': Icons.sports_esports,
    'fitness_center': Icons.fitness_center,
    'sports_soccer': Icons.sports_soccer,
    'sports_basketball': Icons.sports_basketball,
    'casino': Icons.casino,
    'pool': Icons.pool,
    'sports_tennis': Icons.sports_tennis,
    'sports_volleyball': Icons.sports_volleyball,
  };

  /// Ikon default kalau nama tidak dikenal.
  static const IconData fallback = Icons.event;

  /// Ambil IconData dari nama yang tersimpan di storage.
  static IconData dariNama(String? nama) => daftar[nama] ?? fallback;

  /// Cari nama untuk sebuah IconData (dipakai saat menyimpan).
  static String namaDariIcon(IconData? icon) {
    for (final entry in daftar.entries) {
      if (entry.value == icon) return entry.key;
    }
    return 'event';
  }
}

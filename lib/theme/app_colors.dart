import 'package:flutter/material.dart';

// Kumpulan warna utama aplikasi Reclub.
// Biar konsisten, semua halaman pakai warna dari sini
// daripada nulis kode warna manual di tiap file.
class AppColors {
  AppColors._(); // biar gak bisa diinstansiasi

  // warna utama (ungu Reclub)
  static const Color primary = Color(0xFF3B2FE0);
  static const Color primaryDark = Color(0xFF2A21A8);
  static const Color primarySoft = Color(0xFFEFEDFF); // versi muda buat background

  // warna aksen (oranye)
  static const Color accent = Color(0xFFF6A81C);
  static const Color accentDark = Color(0xFFE07B00);

  // warna dasar
  static const Color background = Color(0xFFF5F5F7);
  static const Color textDark = Color(0xFF1D1D2B);
  static const Color textGrey = Color(0xFF7A7A8C);
}

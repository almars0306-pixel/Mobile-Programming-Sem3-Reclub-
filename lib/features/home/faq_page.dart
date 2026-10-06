import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  static const Color _garis = Color(0xFFE5E7EB);

  static const List<({String judul, List<({String tanya, String jawab})> isi})>
      _kategori = [
    (
      judul: 'Artikel Pilihan',
      isi: [
        (
          tanya: 'Bagaimana cara mengirim hasil pertandingan ke DUPR?',
          jawab:
              'Buka halaman Event, pilih pertandingan yang sudah selesai, lalu '
                  'tekan "Kirim ke DUPR". Pastikan akun DUPR kamu sudah terhubung.',
        ),
        (
          tanya: 'Bagaimana cara membuat klub?',
          jawab:
              'Buka tab Club, tekan tombol "Buat Klub", isi nama, lokasi, dan '
                  'deskripsi klub, lalu simpan. Kamu otomatis menjadi admin klub.',
        ),
        (
          tanya: 'Reclub tidak berfungsi',
          jawab:
              'Coba tutup lalu buka kembali aplikasi, periksa koneksi internet, '
                  'dan pastikan aplikasi sudah versi terbaru. Kalau masih bermasalah, '
                  'hubungi tim dukungan kami.',
        ),
        (
          tanya: 'Bagaimana cara menghapus pertemuan (meet)?',
          jawab:
              'Buka pertemuan yang kamu buat, tekan ikon menu di pojok kanan atas, '
                  'lalu pilih "Hapus pertemuan". Hanya pembuat pertemuan yang bisa '
                  'menghapusnya.',
        ),
        (
          tanya: 'Bagaimana cara menghapus atau menonaktifkan akun?',
          jawab:
              'Buka Pengaturan → Akun, lalu pilih opsi hapus atau nonaktifkan '
                  'akun. Penghapusan akun bersifat permanen dan tidak bisa dibatalkan.',
        ),
        (
          tanya: 'Bagaimana cara memutuskan akun DUPR saya?',
          jawab:
              'Buka Pengaturan → Akun, lalu pilih "Putuskan DUPR". Riwayat '
                  'pertandingan yang sudah terkirim tidak akan terhapus.',
        ),
      ],
    ),
    (
      judul: 'Informasi Umum',
      isi: [
        (
          tanya: 'Bagaimana cara menyewa peralatan untuk pertemuan saya?',
          jawab:
              'Saat membuat pertemuan, aktifkan opsi "Sewa peralatan" dan pilih '
                  'peralatan yang dibutuhkan. Ketersediaan tergantung penyedia lokasi.',
        ),
        (
          tanya: 'Bagaimana cara mengubah email akun?',
          jawab:
              'Buka Pengaturan → Akun, ubah kolom E-mail, lalu tekan Simpan.',
        ),
        (
          tanya: 'Bagaimana cara mengubah alamat saya?',
          jawab:
              'Buka Pengaturan → Lokasi, isi alamat baru, lalu tekan Simpan.',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.textDark,
        title: const Text(
          'FAQs',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            for (final kategori in _kategori) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _garis),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                      child: Text(
                        kategori.judul,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    for (final item in kategori.isi)
                      Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          childrenPadding:
                              const EdgeInsets.fromLTRB(20, 0, 20, 16),
                          expandedCrossAxisAlignment:
                              CrossAxisAlignment.start,
                          title: Text(
                            item.tanya,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textDark,
                            ),
                          ),
                          children: [
                            Text(
                              item.jawab,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
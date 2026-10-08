import 'package:flutter/material.dart';
import '../../auth_service.dart';
import '../../theme/app_colors.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  static const List<({String nama, bool tersedia})> _daftarBahasa = [
    (nama: 'Bahasa Indonesia', tersedia: true),
    (nama: 'English', tersedia: false), 
  ];

  late String _dipilih;

  @override
  void initState() {
    super.initState();

    _dipilih = AuthService.instance.currentLanguage;
  }

  void _simpan() {
    final berhasil = AuthService.instance.updateLanguage(language: _dipilih);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            berhasil ? 'Bahasa berhasil disimpan' : 'Gagal menyimpan bahasa',
          ),
        ),
      );

    if (berhasil) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.textDark,
        title: const Text(
          'Bahasa',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primarySoft,
                ),
                child: const Icon(
                  Icons.language_rounded,
                  size: 44,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 28),

              ..._daftarBahasa.map((item) {
                final bahasa = item.nama;
                final aktif = bahasa == _dipilih;
                final bisaDipilih = item.tersedia;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    // null = tidak bisa diklik
                    onTap: bisaDipilih
                        ? () => setState(() => _dipilih = bahasa)
                        : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: bisaDipilih
                            ? Colors.white
                            : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: aktif
                              ? AppColors.primary
                              : const Color(0xFFE5E7EB),
                          width: aktif ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              bahasa,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: bisaDipilih
                                    ? AppColors.textDark
                                    : Colors.black38,
                              ),
                            ),
                          ),
                          if (!bisaDipilih)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE5E7EB),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Segera hadir',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          if (aktif)
                            const Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.primary,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _simpan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
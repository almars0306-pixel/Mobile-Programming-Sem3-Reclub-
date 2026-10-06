import 'package:flutter/material.dart';
import '../../auth_service.dart';
import '../../theme/app_colors.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late int _rating;

  static const List<String> _keterangan = [
    'Ketuk bintang untuk memberi rating',
    'Sangat buruk',
    'Kurang bagus',
    'Cukup',
    'Bagus',
    'Sangat bagus!',
  ];

  @override
  void initState() {
    super.initState();
    _rating = AuthService.instance.currentRating;
  }

  void _simpan() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Pilih jumlah bintang dulu')),
        );
      return;
    }

    final berhasil = AuthService.instance.updateRating(rating: _rating);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            berhasil ? 'Terima kasih atas ratingnya!' : 'Gagal menyimpan rating',
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
          'Review komunitas',
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
                  Icons.thumb_up_alt_rounded,
                  size: 44,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Bagaimana pengalamanmu\nmemakai Reclub?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 28),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) {
                  final nomor = i + 1;
                  final aktif = nomor <= _rating;
                  return IconButton(
                    onPressed: () => setState(() => _rating = nomor),
                    iconSize: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      aktif ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: aktif ? Colors.amber : Colors.black38,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12),
              Text(
                _keterangan[_rating],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 36),

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
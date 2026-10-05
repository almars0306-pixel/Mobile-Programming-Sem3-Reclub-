import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

// Kotak pencarian di bagian atas home.
// Hasil ketikannya dikirim lewat onChanged,
// tombol tune di kanan buat filter (opsional, lewat onFilterTap).
class AppSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  const AppSearchBar({
    super.key,
    this.hintText = 'Cari event atau club...',
    this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.5),
          icon: const Icon(Icons.search_rounded, color: AppColors.primary),
          border: InputBorder.none,
          suffixIcon: IconButton(
            tooltip: 'Filter',
            onPressed: onFilterTap,
            icon: const Icon(
              Icons.tune_rounded,
              color: AppColors.textGrey,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

// Kartu club buat list "Club Populer" di beranda.
// Pengganti ListTile sementara yang kemarin.
class ClubCard extends StatelessWidget {
  final String name;
  final int members;
  final IconData icon;

  // warna gradient avatar, bisa disesuaikan per club
  final List<Color> avatarColors;
  final VoidCallback? onTap;

  const ClubCard({
    super.key,
    required this.name,
    required this.members,
    required this.icon,
    this.avatarColors = const [AppColors.accent, AppColors.accentDark],
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // avatar club dengan gradient
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: avatarColors,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, size: 26, color: Colors.white),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.groups_rounded,
                        size: 14,
                        color: AppColors.textGrey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$members anggota',
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // pill "Lihat" sebagai penanda bisa diklik
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Lihat',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

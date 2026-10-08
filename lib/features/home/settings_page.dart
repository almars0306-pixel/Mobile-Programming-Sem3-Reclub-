import 'package:flutter/material.dart';
import '../../auth_service.dart';
import '../../theme/app_colors.dart';
import 'account_page.dart';
import 'faq_page.dart';
import 'language_page.dart';
import 'location_page.dart';
import 'review_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const Color _garis = Color(0xFFE5E7EB);
  static const Color _merah = Color(0xFFE53935);

  void _menuBelumAda(BuildContext context, String nama) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('Menu $nama belum tersedia')),
      );
  }

  Future<void> _konfirmasiKeluar(BuildContext context) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari akun?'),
        content: const Text('Kamu perlu login lagi untuk masuk ke Reclub.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Keluar',
              style: TextStyle(color: _merah),
            ),
          ),
        ],
      ),
    );

    if (yakin == true && context.mounted) {
      AuthService.instance.logout();
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 20),
              child: Text(
                'Pengaturan',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
            ),

            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border.symmetric(
                  horizontal: BorderSide(color: _garis),
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    _menuCepat(
                      context,
                      icon: Icons.person_outline_rounded,
                      label: 'Akun',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AccountPage(),
                        ),
                      ),
                    ),
                    const VerticalDivider(width: 1, color: _garis),
                    _menuCepat(
                      context,
                      icon: Icons.help_outline_rounded,
                      label: 'FAQs',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FaqPage(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _itemMenu(
                    context,
                    icon: Icons.location_on_outlined,
                    label: 'Lokasi',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LocationPage(),
                      ),
                    ),
                  ),
                  _itemMenu(
                    context,
                    icon: Icons.language_rounded,
                    label: 'Bahasa',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LanguagePage(),
                      ),
                    ),
                  ),
                  _itemMenu(
                    context,
                    icon: Icons.thumb_up_alt_outlined,
                    label: 'Review komunitas',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ReviewPage(),
                      ),
                    ),
                  ),
                  _itemMenu(
                    context,
                    icon: Icons.logout_rounded,
                    label: 'Keluar',
                    warna: _merah,
                    tampilPanah: false,
                    onTap: () => _konfirmasiKeluar(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCepat(
    BuildContext context, {
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap ?? () => _menuBelumAda(context, label),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 34, color: AppColors.textDark),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemMenu(
    BuildContext context, {
    required IconData icon,
    required String label,
    Color warna = AppColors.textDark,
    bool tampilPanah = true,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap ?? () => _menuBelumAda(context, label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: _garis)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: warna),
            const SizedBox(width: 18),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: warna,
                ),
              ),
            ),
            if (tampilPanah)
              const Icon(
                Icons.chevron_right_rounded,
                size: 28,
                color: AppColors.textDark,
              ),
          ],
        ),
      ),
    );
  }
}
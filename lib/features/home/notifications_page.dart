import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import 'notif_controller.dart';

/// Halaman daftar notifikasi.
///
/// Tile yang belum dibaca punya titik biru dan tampil penuh,
/// yang sudah dibaca tampil pudar. Ketuk tile untuk menandai dibaca.
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NotifController>();
    final daftar = controller.daftar;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notifikasi'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          if (controller.belumDibaca > 0)
            TextButton(
              onPressed: () {
                context.read<NotifController>().tandaiSemuaDibaca();
              },
              child: const Text(
                'Tandai dibaca',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: daftar.isEmpty
          ? const _NotifKosong()
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: daftar.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final notif = daftar[index];
                return _NotifTile(
                  notif: notif,
                  onTap: () =>
                      context.read<NotifController>().tandaiDibaca(index),
                );
              },
            ),
    );
  }
}

/// Satu baris notifikasi.
class _NotifTile extends StatelessWidget {
  final Notifikasi notif;
  final VoidCallback onTap;

  const _NotifTile({required this.notif, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        // yang sudah dibaca tampil pudar biar kelihatan bedanya
        opacity: notif.dibaca ? 0.55 : 1,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(notif.ikon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notif.judul,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        if (!notif.dibaca)
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(left: 6),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      notif.isi,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: AppColors.textGrey,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      notif.waktu,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tampilan saat semua notifikasi sudah dibaca.
class _NotifKosong extends StatelessWidget {
  const _NotifKosong();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt_rounded, size: 54, color: AppColors.primary),
          SizedBox(height: 12),
          Text(
            'Semua notifikasi sudah dibaca',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Kabar olahraga baru muncul di sini',
            style: TextStyle(fontSize: 12.5, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }
}

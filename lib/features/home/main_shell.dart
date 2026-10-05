import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import 'event_controller.dart';
import 'home_page.dart';
import 'widgets/event_page.dart';

/// Kerangka utama app setelah login.
///
/// - Tab bawah (Beranda, Event, Club, Profil) pakai IndexedStack
///   biar posisi scroll dan isi tiap tab tidak hilang saat pindah tab.
/// - Daftar event diambil dari EventController (state management),
///   jadi beranda dan tab event selalu tampil data yang sama.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  // Pindah tab dari luar halaman (misal tombol "Lihat semua" di beranda).
  void _pindahKeTabEvent() {
    setState(() {
      _selectedIndex = 1; // 1 = tab Event
    });
  }

  void _pindahKeTabClub() {
    setState(() {
      _selectedIndex = 2; // 2 = tab Club
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventController = context.watch<EventController>();

    final List<Widget> pages = [
      HomePage(
        onOpenEvents: _pindahKeTabEvent,
        onOpenClub: _pindahKeTabClub,
      ),
      EventPage(
        events: eventController.events,
        onEventChanged: (updatedList) {
          // Simpan perubahan (tambah/hapus event) ke controller,
          // otomatis tersimpan ke storage dan beranda ikut ter-update.
          eventController.setEvents(updatedList);
        },
      ),
      const _PlaceholderPage(title: 'Club'),
      const _PlaceholderPage(title: 'Profil'),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      // NavigationBar (Material 3) biar tampilannya lebih modern
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        height: 68,
        backgroundColor: Colors.white,
        indicatorColor: AppColors.primarySoft,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        // warna ikon tab aktif ngikutin colorScheme.primary dari tema
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_outlined),
            selectedIcon: Icon(Icons.event_rounded),
            label: 'Event',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups_rounded),
            label: 'Club',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// Halaman sementara buat tab yang belum dibuat
class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primarySoft,
              ),
              child: const Icon(
                Icons.handyman_rounded,
                size: 40,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Halaman $title',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Sedang dikerjakan teman kamu',
              style: TextStyle(
                fontSize: 13.5,
                color: AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'home_page.dart';
import 'widgets/event_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  // HANYA MENYISAKAN EVENT LARI DAN EVENT YANG NANTI DIBUAT USER
  final List<Map<String, dynamic>> _sharedEvents = [
    {
      'title': 'EVENT LARI',
      'location': 'Gelora Bung Karno',
      'date': '24 Sep 2026',
      'icon': Icons.directions_run,
      'description': 'Lari santai sore hari bareng komunitas. Terbuka untuk umum!',
      'creator_id': 'user_lain', // Milik orang lain (tidak bisa dihapus)
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(events: _sharedEvents),
      EventPage(
        events: _sharedEvents,
        onEventChanged: (updatedList) {
          setState(() {
            // Memperbarui UI secara real-time saat ada event yang ditambah/dihapus
          });
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

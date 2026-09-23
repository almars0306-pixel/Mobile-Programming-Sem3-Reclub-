import 'package:flutter/material.dart';
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF3B2FE0),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_outlined),
            activeIcon: Icon(Icons.event),
            label: 'Event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            activeIcon: Icon(Icons.groups),
            label: 'Club',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF3B2FE0),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Halaman $title belum dibuat',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../profile/profile_page.dart';
import '../../theme/app_colors.dart';
import 'event_controller.dart';
import 'home_page.dart';
import 'settings_page.dart';
import 'widgets/event_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;


  void _pindahKeTabEvent() {
    setState(() {
      _selectedIndex = 1; 
    });
  }

  void _pindahKeTabClub() {
    setState(() {
      _selectedIndex = 2; 
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

          eventController.setEvents(updatedList);
        },
      ),
      const _PlaceholderPage(title: 'Club'),
      const ProfilePage(),
      const SettingsPage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
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
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Pengaturan',
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
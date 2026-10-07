import 'package:flutter/material.dart';
import 'filter_chip_widget.dart';
import 'floating_nav_bar.dart';
import 'discover_bottom_sheet.dart';

class ClubsHomeScreen extends StatefulWidget {
  const ClubsHomeScreen({super.key});

  @override
  State<ClubsHomeScreen> createState() => _ClubsHomeScreenState();
}

class _ClubsHomeScreenState extends State<ClubsHomeScreen> {
  int _selectedFilterIndex = 2;

  void _showDiscoverBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DiscoverBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  const Text(
                    'Hi, Aldo Bambang',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // App / Social Icon
                  Column(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B41E3),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Text(
                            'R',
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Instagram',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Filter Chips
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilterChipWidget(
                        label: 'Active',
                        isSelected: _selectedFilterIndex == 0,
                        onTap: () => setState(() => _selectedFilterIndex = 0),
                      ),
                      const SizedBox(width: 8),
                      FilterChipWidget(
                        label: 'With friends',
                        isSelected: _selectedFilterIndex == 1,
                        onTap: () => setState(() => _selectedFilterIndex = 1),
                      ),
                      const SizedBox(width: 8),
                      FilterChipWidget(
                        label: 'By clubs',
                        isSelected: _selectedFilterIndex == 2,
                        onTap: () => setState(() => _selectedFilterIndex = 2),
                      ),
                    ],
                  ),
                  // Empty State
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sports_baseball_outlined,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No activity by clubs',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton(
                            onPressed: () => _showDiscoverBottomSheet(context),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xFF3B41E3),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 10,
                              ),
                            ),
                            child: const Text(
                              'Discover',
                              style: TextStyle(
                                color: Color(0xFF3B41E3),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const FloatingNavBar(),
          ],
        ),
      ),
    );
  }
}
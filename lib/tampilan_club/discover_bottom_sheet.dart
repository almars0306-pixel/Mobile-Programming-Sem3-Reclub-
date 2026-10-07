import 'package:flutter/material.dart';
import 'club.dart'; // Impor sesama file dalam folder tampilan_clubs

class DiscoverBottomSheet extends StatefulWidget {
  const DiscoverBottomSheet({super.key});

  @override
  State<DiscoverBottomSheet> createState() => _DiscoverBottomSheetState();
}

class _DiscoverBottomSheetState extends State<DiscoverBottomSheet> {
  String _selectedSport = 'All Sports';

  @override
  Widget build(BuildContext context) {
    final filteredClubs = _selectedSport == 'All Sports'
        ? sampleClubs
        : sampleClubs.where((club) => club.sport == _selectedSport).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Top Header Filter Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, size: 24),
                  onPressed: () => Navigator.pop(context),
                ),
                Row(
                  children: [
                    const Text('Near Home · 20 km',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const Icon(Icons.keyboard_arrow_down, size: 18),
                    const SizedBox(width: 12),
                    // Dropdown Olahraga
                    PopupMenuButton<String>(
                      onSelected: (value) => setState(() => _selectedSport = value),
                      itemBuilder: (context) => [
                        'All Sports',
                        'Padel',
                        'Sepak Bola',
                        'Basket',
                        'Tenis',
                        'Bulu Tangkis',
                        'Futsal',
                      ].map((sport) => PopupMenuItem(value: sport, child: Text(sport))).toList(),
                      child: Row(
                        children: [
                          Text(
                            _selectedSport == 'All Sports' ? 'Sports' : _selectedSport,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          const Icon(Icons.keyboard_arrow_down, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Tab Navigation
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTabItem('CLUBS', isSelected: true),
                _buildTabItem('MEETS'),
                _buildTabItem('COMPS'),
                _buildTabItem('VENUES'),
                _buildTabItem('PEOPLE'),
              ],
            ),
          ),
          const Divider(height: 1),

          // Daftar Klub
          Expanded(
            child: ListView.separated(
              itemCount: filteredClubs.length,
              separatorBuilder: (context, index) => Divider(color: Colors.grey.shade200, height: 1),
              itemBuilder: (context, index) {
                final club = filteredClubs[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundColor: club.color,
                    child: Icon(club.icon, color: Colors.white, size: 26),
                  ),
                  title: Text(
                    club.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.group_outlined, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(club.members, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(width: 16),
                        Icon(club.icon, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(club.level, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? const Color(0xFF3B41E3) : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? const Color(0xFF3B41E3) : Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
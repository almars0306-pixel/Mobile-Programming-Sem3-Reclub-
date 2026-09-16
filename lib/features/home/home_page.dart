import 'package:flutter/material.dart';

import 'widgets/app_search_bar.dart';
import 'widgets/event_card.dart';
import 'widgets/section_header.dart';

// Data sementara buat ngisi tampilan home.
// Nanti diganti pakai model + dummy data dari lib/data.
class _EventItem {
  final String title;
  final String location;
  final String date;
  final IconData icon;

  const _EventItem({
    required this.title,
    required this.location,
    required this.date,
    required this.icon,
  });
}

const List<_EventItem> _eventMingguIni = [
  _EventItem(
    title: 'Fun Futsal Sabtu',
    location: 'GOR Tanjung Duren',
    date: 'Sab, 20 Sep',
    icon: Icons.sports_soccer,
  ),
  _EventItem(
    title: 'Badminton Bareng',
    location: 'Hall Grogol',
    date: 'Min, 21 Sep',
    icon: Icons.sports_tennis,
  ),
  _EventItem(
    title: 'Morning Run 5K',
    location: 'GBK Senayan',
    date: 'Min, 21 Sep',
    icon: Icons.directions_run,
  ),
  _EventItem(
    title: 'Basket 3 on 3',
    location: 'Lapangan Untar',
    date: 'Sel, 23 Sep',
    icon: Icons.sports_basketball,
  ),
];

const List<String> _kategori = [
  'Semua',
  'Futsal',
  'Badminton',
  'Basket',
  'Lari',
  'Voli',
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _kategoriTerpilih = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // header sapaan + ikon notifikasi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, Reclubber!',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF3B2FE0),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Mau olahraga apa hari ini?',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: halaman notifikasi
                      },
                      icon: const Icon(Icons.notifications_none, size: 28),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              const AppSearchBar(),
              const SizedBox(height: 20),

              // chip kategori olahraga
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _kategori.length,
                  itemBuilder: (context, index) {
                    final bool aktif = index == _kategoriTerpilih;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(_kategori[index]),
                        selected: aktif,
                        onSelected: (_) {
                          setState(() {
                            _kategoriTerpilih = index;
                          });
                        },
                        selectedColor: const Color(0xFF3B2FE0),
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: aktif ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        showCheckmark: false,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              SectionHeader(
                title: 'Event Minggu Ini',
                onSeeAll: () {
                  // TODO: pindah ke tab Event
                },
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20),
                  itemCount: _eventMingguIni.length,
                  itemBuilder: (context, index) {
                    final event = _eventMingguIni[index];
                    return EventCard(
                      title: event.title,
                      location: event.location,
                      date: event.date,
                      icon: event.icon,
                      onTap: () {
                        // TODO: buka detail event
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              const SectionHeader(title: 'Club Populer'),
              const SizedBox(height: 12),

              // sementara pakai ListTile biasa, nanti diganti ClubCard
              ...List.generate(3, (index) {
                final nama = [
                  'Untar Futsal Club',
                  'Jakarta Runners',
                  'Smash Badminton',
                ][index];
                final anggota = [128, 340, 76][index];
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFF6A81C),
                      child: Icon(Icons.groups, color: Colors.white),
                    ),
                    title: Text(
                      nama,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text('$anggota anggota'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: buka detail club
                    },
                  ),
                );
              }),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'widgets/app_search_bar.dart';
import 'widgets/club_card.dart';
import 'widgets/event_card.dart';
import 'widgets/section_header.dart';

const List<String> _kategori = [
  'Semua',
  'Futsal',
  'Badminton',
  'Basket',
  'Lari',
  'Voli',
];

class HomePage extends StatefulWidget {
  final List<Map<String, dynamic>> events; // Menerima data event dari MainShell

  const HomePage({
    super.key,
    required this.events,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _kategoriTerpilih = 0;
  String _query = '';

  // Nentuin kategori event dari ikonnya,
  // jadi gak perlu ubah struktur data event punya MainShell.
  String _kategoriDariIcon(IconData icon) {
    switch (icon) {
      case Icons.sports_soccer:
        return 'Futsal';
      case Icons.sports_tennis:
        return 'Badminton';
      case Icons.sports_basketball:
        return 'Basket';
      case Icons.directions_run:
        return 'Lari';
      case Icons.sports_volleyball:
        return 'Voli';
      default:
        return 'Semua';
    }
  }

  // Event yang muncul = sesuai kategori + sesuai kata kunci pencarian
  List<Map<String, dynamic>> get _filteredEvents {
    final query = _query.toLowerCase();
    return widget.events.where((event) {
      final bool cocokKategori = _kategoriTerpilih == 0 ||
          _kategoriDariIcon(event['icon']) == _kategori[_kategoriTerpilih];

      final bool cocokQuery = query.isEmpty ||
          event['title'].toString().toLowerCase().contains(query) ||
          event['location'].toString().toLowerCase().contains(query);

      return cocokKategori && cocokQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final events = _filteredEvents;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // header sapaan + avatar + ikon notifikasi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.primary, AppColors.primaryDark],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Halo, Reclubber!',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Mau olahraga apa hari ini?',
                            style: TextStyle(
                              fontSize: 13.5,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // tombol notifikasi dengan titik merah
                    GestureDetector(
                      onTap: () {
                        // TODO: halaman notifikasi
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black.withValues(alpha: 0.05),
                          ),
                        ),
                        child: const Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Center(
                              child: Icon(
                                Icons.notifications_none_rounded,
                                size: 24,
                                color: AppColors.textDark,
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 11,
                              child: _NotifDot(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              AppSearchBar(
                onChanged: (value) => setState(() => _query = value),
              ),
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
                        selectedColor: AppColors.primary,
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

              if (events.isEmpty)
                const _EmptyEventState()
              else
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return EventCard(
                        title: event['title'],
                        location: event['location'],
                        date: event['date'],
                        icon: event['icon'],
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

              ClubCard(
                name: 'Untar Futsal Club',
                members: 128,
                icon: Icons.sports_soccer_rounded,
                avatarColors: const [AppColors.primary, AppColors.primaryDark],
                onTap: () {
                  // TODO: buka detail club
                },
              ),
              ClubCard(
                name: 'Jakarta Runners',
                members: 340,
                icon: Icons.directions_run_rounded,
                avatarColors: const [AppColors.accent, AppColors.accentDark],
                onTap: () {
                  // TODO: buka detail club
                },
              ),
              ClubCard(
                name: 'Smash Badminton',
                members: 76,
                icon: Icons.sports_tennis_rounded,
                avatarColors: const [Color(0xFF00B894), Color(0xFF00875F)],
                onTap: () {
                  // TODO: buka detail club
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// Titik merah kecil di ikon notifikasi.
class _NotifDot extends StatelessWidget {
  const _NotifDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}

// Tampilan pas event yang dicari/difilter gak ada.
class _EmptyEventState extends StatelessWidget {
  const _EmptyEventState();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 44,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            const Text(
              'Event tidak ditemukan',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Coba kata kunci atau kategori lain',
              style: TextStyle(
                fontSize: 12.5,
                color: AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

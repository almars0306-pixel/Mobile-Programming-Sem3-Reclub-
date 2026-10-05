import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/app_colors.dart';
import 'event_controller.dart';
import 'notif_controller.dart';
import 'notifications_page.dart';
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

/// Daftar club yang ditampilkan di beranda (data contoh sementara,
/// nanti diganti data dari bagian Club).
const List<Map<String, dynamic>> _semuaClub = [
  {
    'name': 'Untar Futsal Club',
    'members': 128,
    'icon': Icons.sports_soccer_rounded,
    'avatarColors': [AppColors.primary, AppColors.primaryDark],
  },
  {
    'name': 'Jakarta Runners',
    'members': 340,
    'icon': Icons.directions_run_rounded,
    'avatarColors': [AppColors.accent, AppColors.accentDark],
  },
  {
    'name': 'Smash Badminton',
    'members': 76,
    'icon': Icons.sports_tennis_rounded,
    'avatarColors': [Color(0xFF00B894), Color(0xFF00875F)],
  },
];

/// Beranda Reclub.
///
/// - Data event diambil langsung dari [EventController] lewat provider,
///   jadi selalu sinkron dengan tab Event (state management).
/// - [onOpenEvents] dipanggil saat user klik "Lihat semua" pada bagian
///   event, [onOpenClub] pada bagian club, biar MainShell pindah tab.
/// - Kategori yang terakhir dipilih user disimpan ke storage
///   (shared_preferences) dan dibuka lagi saat app dijalankan.
/// - Pencarian menyaring event dan club sekaligus.
class HomePage extends StatefulWidget {
  final VoidCallback onOpenEvents;
  final VoidCallback onOpenClub;

  const HomePage({
    super.key,
    required this.onOpenEvents,
    required this.onOpenClub,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Key penyimpanan kategori terpilih di shared_preferences.
  static const String _kategoriKey = 'reclub_kategori';

  int _kategoriTerpilih = 0;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _muatKategoriTersimpan();
  }

  // Ambil kategori terakhir yang dipilih user dari storage.
  Future<void> _muatKategoriTersimpan() async {
    final prefs = await SharedPreferences.getInstance();
    final tersimpan = prefs.getInt(_kategoriKey);
    if (!mounted || tersimpan == null) return;
    setState(() {
      _kategoriTerpilih = tersimpan;
    });
  }

  // Simpan kategori yang baru dipilih ke storage.
  Future<void> _simpanKategori(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kategoriKey, index);
  }

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
  List<Map<String, dynamic>> _filterEvents(List<Map<String, dynamic>> events) {
    final query = _query.toLowerCase();
    return events.where((event) {
      final bool cocokKategori = _kategoriTerpilih == 0 ||
          _kategoriDariIcon(event['icon']) == _kategori[_kategoriTerpilih];

      final bool cocokQuery = query.isEmpty ||
          event['title'].toString().toLowerCase().contains(query) ||
          event['location'].toString().toLowerCase().contains(query);

      return cocokKategori && cocokQuery;
    }).toList();
  }

  // Club juga ikut disaring kata kunci pencarian.
  List<Map<String, dynamic>> get _clubCocok {
    final query = _query.toLowerCase();
    if (query.isEmpty) return _semuaClub;
    return _semuaClub
        .where((club) =>
            club['name'].toString().toLowerCase().contains(query) ||
            club['members'].toString().contains(query))
        .toList();
  }

  // Tarik ke bawah di beranda = muat ulang event dari storage.
  Future<void> _muatUlangEvent() async {
    // kasih jeda sekejap biar animasi refresh terlihat natural
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    await context.read<EventController>().muatDariStorage();
  }

  // Detail event muncul dari bawah layar (bottom sheet).
  void _tampilkanDetailEvent(Map<String, dynamic> event) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primary, AppColors.primaryDark],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(event['icon'], color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${event['date']} • ${event['location']}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Deskripsi Event',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                event['description'],
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context); // tutup detail dulu
                    widget.onOpenEvents(); // pindah ke tab Event
                  },
                  icon: const Icon(Icons.event_rounded, size: 20),
                  label: const Text(
                    'Kelola di Tab Event',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _bukaNotifikasi() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationsPage()),
    );
  }

  // Sementara kasih info dulu, halaman detail club nanti dibuat
  // oleh teman yang pegang bagian Club.
  void _infoClubBelumTersedia() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Detail club akan tersedia segera'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // watch: otomatis rebuild kalau ada event ditambah/dihapus
    // dari tab Event, karena keduanya pakai EventController yang sama.
    final events = _filterEvents(context.watch<EventController>().events);
    final clubs = _clubCocok;
    // Titik merah di lonceng hanya muncul kalau ada notifikasi belum dibaca.
    final belumDibaca = context.watch<NotifController>().belumDibaca;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: _muatUlangEvent,
        child: SingleChildScrollView(
          // harus selalu bisa discroll biar tarik-ke-bawah tetap jalan
          // walau kontennya pendek
          physics: const AlwaysScrollableScrollPhysics(),
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
                      onTap: _bukaNotifikasi,
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
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            const Center(
                              child: Icon(
                                Icons.notifications_none_rounded,
                                size: 24,
                                color: AppColors.textDark,
                              ),
                            ),
                            if (belumDibaca > 0)
                              Positioned(
                                top: 10,
                                right: 11,
                                child: KeyedSubtree(
                                  key: const ValueKey('notif_dot'),
                                  child: const _NotifDot(),
                                ),
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
                          _simpanKategori(index);
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
                onSeeAll: widget.onOpenEvents,
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
                        onTap: () => _tampilkanDetailEvent(event),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 24),

              // Section club juga bisa "Lihat semua" ke tab Club.
              SectionHeader(
                title: 'Club Populer',
                onSeeAll: widget.onOpenClub,
              ),
              const SizedBox(height: 12),

              if (clubs.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Tidak ada club yang cocok dengan pencarian',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textGrey,
                    ),
                  ),
                )
              else
                ...clubs.map(
                  (club) => ClubCard(
                    name: club['name'],
                    members: club['members'],
                    icon: club['icon'],
                    avatarColors: club['avatarColors'],
                    onTap: _infoClubBelumTersedia,
                  ),
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

import 'package:flutter/material.dart';
import 'event_card.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  // Simulasi ID user yang sedang login saat ini
  final String _currentUserId = 'user_akbar';

  // Data list event dengan tambahan deskripsi (bio) dan creator_id
  final List<Map<String, dynamic>> _events = [
    {
      'title': 'EVENT LARI',
      'location': 'Gelora Bung Karno',
      'date': '24 Sep 2026',
      'icon': Icons.directions_run,
      'description': 'Lari santai sore hari bareng komunitas. Terbuka untuk umum!',
      'creator_id': 'user_lain', // Dibuat oleh orang lain, tidak bisa dihapus
    },

  ];

  // Menampilkan pop-up detail event
  void _tampilkanDetailEvent(int index) {
    final event = _events[index];
    final bool isMyEvent = event['creator_id'] == _currentUserId;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6A81C).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(event['icon'], color: const Color(0xFFF6A81C), size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['title'],
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${event['date']} • ${event['location']}',
                          style: const TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Deskripsi Event',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                event['description'],
                style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
              ),
              const SizedBox(height: 32),
              
              // Logika Tombol Hapus: Hanya muncul jika creator_id sama dengan _currentUserId
              if (isMyEvent)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _events.removeAt(index);
                      });
                      Navigator.pop(context); // Tutup pop-up setelah dihapus
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Hapus Event Saya', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                      foregroundColor: Colors.red,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                )
              else
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Kamu tidak bisa menghapus event milik pengguna lain.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // Menampilkan pop-up form tambah event
  void _tampilkanFormTambahEvent() {
    final titleController = TextEditingController();
    final locationController = TextEditingController();
    final dateController = TextEditingController();
    final descController = TextEditingController(); // Tambahan controller untuk bio/deskripsi

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24, right: 24, top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tambah Event Baru',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF3B2FE0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Nama Event', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Lokasi', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Pilih Tanggal',
                  suffixIcon: const Icon(Icons.calendar_month, color: Color(0xFF3B2FE0)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  );
                  if (pickedDate != null) {
                    final List<String> namaBulan = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Ags', 'Sep', 'Okt', 'Nov', 'Des'];
                    dateController.text = '${pickedDate.day} ${namaBulan[pickedDate.month - 1]} ${pickedDate.year}';
                  }
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Detail / Bio Event', 
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty && dateController.text.isNotEmpty) {
                      setState(() {
                        _events.add({
                          'title': titleController.text,
                          'location': locationController.text.isNotEmpty ? locationController.text : 'TBA',
                          'date': dateController.text,
                          'description': descController.text.isNotEmpty ? descController.text : 'Tidak ada deskripsi tambahan.',
                          'icon': Icons.local_activity,
                          'creator_id': _currentUserId, // Event baru otomatis milik Anda
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B2FE0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Simpan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event'),
        backgroundColor: const Color(0xFF3B2FE0),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _events.length,
        itemBuilder: (context, index) {
          final event = _events[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: EventCard(
              title: event['title'],
              location: event['location'],
              date: event['date'],
              icon: event['icon'],
              // Panggil pop-up detail saat kartu diklik
              onTap: () => _tampilkanDetailEvent(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tampilkanFormTambahEvent,
        backgroundColor: const Color(0xFFF6A81C),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}
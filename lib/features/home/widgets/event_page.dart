import 'package:flutter/material.dart';
import 'event_card.dart';

class EventPage extends StatefulWidget {
  final List<Map<String, dynamic>> events;
  final ValueChanged<List<Map<String, dynamic>>> onEventChanged;

  const EventPage({
    super.key,
    required this.events,
    required this.onEventChanged,
  });

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final String _currentUserId = 'user_akbar';
  final List<IconData> _pilihanIkon = [
    Icons.local_activity,
    Icons.directions_run,
    Icons.sports_esports,
    Icons.fitness_center,
    Icons.sports_soccer,
    Icons.sports_basketball,
    Icons.casino,
    Icons.pool,
  ];

  void _tampilkanDetailEvent(int index) {
    final event = widget.events[index];
    final bool isMyEvent = event['creator_id'] == _currentUserId;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
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
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6A81C).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(event['icon'], color: const Color(0xFFF6A81C), size: 36),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event['title'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('${event['date']} • ${event['location']}', style: const TextStyle(color: Colors.grey, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Deskripsi Event', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(event['description'], style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.black87)),
              const SizedBox(height: 32),

              if (isMyEvent)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        widget.events.removeAt(index);
                      });
                      widget.onEventChanged(widget.events);
                      Navigator.pop(context);
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
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
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

  void _tampilkanFormTambahEvent() {
    final titleController = TextEditingController();
    final locationController = TextEditingController();
    final dateController = TextEditingController();
    final descController = TextEditingController();
    IconData ikonTerpilih = _pilihanIkon.first;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 24, right: 24, top: 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tambah Event Baru', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF3B2FE0))),
                    const SizedBox(height: 20),
                    const Text('Pilih Tema Ikon', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _pilihanIkon.length,
                        itemBuilder: (context, index) {
                          final icon = _pilihanIkon[index];
                          final isSelected = ikonTerpilih == icon;
                          return GestureDetector(
                            onTap: () {
                              setModalState(() {
                                ikonTerpilih = icon;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 12),
                              width: 60,
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFF3B2FE0) : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: isSelected ? const Color(0xFF3B2FE0) : Colors.grey.shade300),
                              ),
                              child: Icon(
                                icon,
                                color: isSelected ? Colors.white : Colors.grey.shade600,
                                size: 28,
                              ),
                            ),
                          );
                        },
                      ),
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
                              widget.events.insert(0, {
                                'title': titleController.text,
                                'location': locationController.text.isNotEmpty ? locationController.text : 'TBA',
                                'date': dateController.text,
                                'description': descController.text.isNotEmpty ? descController.text : 'Tidak ada deskripsi tambahan.',
                                'icon': ikonTerpilih,
                                'creator_id': _currentUserId, 
                              });
                            });
                            widget.onEventChanged(widget.events);
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
              ),
            );
          },
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
        itemCount: widget.events.length,
        itemBuilder: (context, index) {
          final event = widget.events[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: EventCard(
              title: event['title'],
              location: event['location'],
              date: event['date'],
              icon: event['icon'],
              width: double.infinity,
              margin: EdgeInsets.zero,
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
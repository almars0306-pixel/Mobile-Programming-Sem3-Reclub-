import 'package:flutter/material.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class ClubItem {
  final String nama;
  final String members;
  final String level;
  final Color color;

  const ClubItem({
    required this.nama,
    required this.members,
    required this.level,
    required this.color,
  });
}

class _ClubPageState extends State<ClubPage> {
  static const bg = Color(0xFFF3F7FF);

  // Daftar club sesuai dengan gambar referensi
  final List<ClubItem> klubAnggota = [
    const ClubItem(
      nama: 'Tennis and Chill',
      members: '5935 Members',
      level: 'All Levels',
      color: Colors.green,
    ),
    const ClubItem(
      nama: 'Rally On Court',
      members: '2223 Members',
      level: 'All Levels',
      color: Colors.blueGrey,
    ),
    const ClubItem(
      nama: 'YUK GAS CLUB',
      members: '760 Members',
      level: 'All Levels',
      color: Colors.teal,
    ),
    const ClubItem(
      nama: 'Kenjo social club',
      members: '268 Members',
      level: 'All Levels',
      color: Colors.black87,
    ),
    const ClubItem(
      nama: 'River Society',
      members: '477 Members',
      level: 'All Levels',
      color: Colors.brown,
    ),
    const ClubItem(
      nama: 'PickleDrive Club',
      members: '988 Members',
      level: 'All Levels',
      color: Colors.greenAccent,
    ),
    const ClubItem(
      nama: 'PWA',
      members: '429 Members',
      level: 'All Levels',
      color: Colors.redAccent,
    ),
    const ClubItem(
      nama: 'Padel Murah Meriah (PMM)',
      members: '1417 Members',
      level: 'All Levels',
      color: Colors.blue,
    ),
  ];

  void _keluarDariKlub(ClubItem klub) {
    setState(() {
      klubAnggota.remove(klub);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Kamu keluar dari ${klub.nama}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text(
          'Klub saya',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Anggota',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Icon(Icons.keyboard_arrow_up, color: Colors.black54),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: klubAnggota.length,
              itemBuilder: (context, index) {
                final klub = klubAnggota[index];
                return Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 1),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundColor: klub.color,
                      child: Text(
                        klub.nama.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    title: Text(
                      klub.nama,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        children: [
                          const Icon(Icons.people_outline,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(klub.members,
                              style: const TextStyle(color: Colors.grey)),
                          const SizedBox(width: 16),
                          const Icon(Icons.sports_tennis,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(klub.level,
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'keluar') {
                          _keluarDariKlub(klub);
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: 'keluar',
                          child: Text('Keluar Klub'),
                        ),
                      ],
                      icon: const Icon(Icons.more_horiz, color: Colors.black54),
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
}
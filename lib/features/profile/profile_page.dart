import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = 'Memuat...';
  String _email = 'Memuat...';
  String _themeStatus = 'Terang'; // Simulasi status tema

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // Mengambil data dari penyimpanan lokal
  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('user_name') ?? 'Pengguna Baru'; 
      _email = prefs.getString('user_email') ?? 'belum_ada@email.com';
    });
  }

  // Dialog untuk Ubah Kata Sandi
  void _showPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ubah Kata Sandi', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Masukkan kata sandi baru',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal', style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kata sandi berhasil diperbarui')));
            },
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Dialog untuk Notifikasi
  void _showNotificationSettings() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Pengaturan Notifikasi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            SwitchListTile(title: const Text('Notifikasi Event Baru'), value: true, onChanged: (val) {}),
            SwitchListTile(title: const Text('Notifikasi Pesan Club'), value: false, onChanged: (val) {}),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], 
      appBar: AppBar(
        title: const Text('Profil Saya', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 30),
              width: double.infinity,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                  ),
                  const SizedBox(height: 16),
                  Text(_name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(_email, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                ],
              ),
            ),
            const SizedBox(height: 10),

            _buildSectionTitle('PENGATURAN AKUN'),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.person_outline,
                    title: 'Edit Profil',
                    onTap: () async {
                      // Menunggu halaman edit selesai, lalu memuat ulang data terbaru
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EditProfilePage()),
                      );
                      if (result == true) {
                        _loadProfileData(); 
                      }
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.lock_outline,
                    title: 'Ubah Kata Sandi',
                    onTap: _showPasswordDialog, // Memanggil fungsi dialog sandi
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            _buildSectionTitle('PREFERENSI APLIKASI'),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.notifications_none, 
                    title: 'Notifikasi', 
                    onTap: _showNotificationSettings, // Memanggil fungsi dialog notifikasi
                  ),
                  _buildDivider(),
                  // Menu Bahasa dihapus
                  _buildMenuItem(
                    icon: Icons.dark_mode_outlined, 
                    title: 'Tema Tampilan', 
                    trailing: _themeStatus, 
                    onTap: () {
                      // Mengubah teks status tema saat diklik
                      setState(() {
                        _themeStatus = _themeStatus == 'Terang' ? 'Gelap' : 'Terang';
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            _buildSectionTitle('LAINNYA'),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildMenuItem(icon: Icons.security, title: 'Kebijakan Privasi', onTap: () {}),
                  _buildDivider(),
                  _buildMenuItem(icon: Icons.help_outline, title: 'Pusat Bantuan', onTap: () {}),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Container(
              color: Colors.white,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Keluar Akun', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 8, top: 16),
      child: Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[600], letterSpacing: 1.2)),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 0.5, indent: 60, color: Color(0xFFEEEEEE));
  }

  Widget _buildMenuItem({required IconData icon, required String title, String? trailing, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: Colors.black87, size: 22),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null) Text(trailing, style: TextStyle(color: Colors.grey[500], fontSize: 13)),
          if (trailing != null) const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
      onTap: onTap,
    );
  }
}
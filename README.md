# Reclub 🏃‍♂️

Aplikasi mobile berbasis **Flutter** untuk mahasiswa yang suka olahraga: cari event
olahraga, buat event sendiri, dan gabung club di kampus. Dibuat sebagai project
Ujian Tengah Semester mata kuliah *Mobile Programming* Semester 3.

## Fitur Utama

- **Beranda** — sapaan, pencarian event real-time, filter kategori olahraga
  (Futsal, Badminton, Basket, Lari, Voli), dan daftar club populer.
- **Event** — lihat semua event, tambah event baru (dengan pemilih ikon dan
  tanggal), hapus event milik sendiri. Event milik orang lain tidak bisa dihapus.
- **Navigasi** — bottom navigation 4 tab (Beranda, Event, Club, Profil) dengan
  `IndexedStack` agar state tiap tab tidak hilang saat berpindah.
- **Login & Onboarding** — halaman onboarding, login, dan sign up.

## Teknologi

| Teknologi | Kegunaan |
|---|---|
| Flutter + Dart | Framework utama |
| `provider` (`ChangeNotifier`) | State management — data event dibagi antar halaman |
| `shared_preferences` | Storage — event & preferensi kategori tersimpan di device |
| `NavigationBar` (Material 3) | Navigasi bottom tab modern |

## Struktur Proyek

```
lib/
├── main.dart                      # Entry point + setup provider global
├── theme/app_colors.dart          # Warna brand Reclub (terpusat)
├── tampilan_utama/                # Onboarding, login, sign up
└── features/
    ├── home/                      # [Aldho] Beranda & navigasi
    │   ├── main_shell.dart        #    Kerangka bottom navigation 4 tab
    │   ├── home_page.dart         #    Beranda: search, filter, club populer
    │   ├── event_controller.dart  #    State management + storage event
    │   └── widgets/               #    AppSearchBar, EventCard, ClubCard,
    │                              #    SectionHeader, EventPage
    └── (club/, profile/, data/    # [Dikerjakan anggota tim lain]
        └── sesuai pembagian tugas)
```

## Pembagian Tugas Tim

| Anggota | Bagian |
|---|---|
| Aldho | Home & navigasi (MainShell, HomePage, widget beranda, state event) |
| Rivaldi | Halaman Event (daftar, tambah/hapus event) |
| Lainnya | Auth, Club, Profil, dan data |

## Cara Menjalankan

```bash
flutter pub get
flutter run
```

Untuk web: `flutter run -d chrome`

## Pengujian

```bash
flutter test
```

Menjalankan unit test `EventController` (storage) dan widget test untuk
`SectionHeader`, `ClubCard`, `EventCard`, dan `HomePage`.

Setiap push otomatis dijalankan `flutter analyze` + `flutter test` lewat
GitHub Actions (lihat `.github/workflows/flutter.yml`).

## Alur Git

1. Kerja di branch masing-masing (`<nama>-<nim>`).
2. Commit bertahap dengan pesan deskriptif.
3. Push lalu buka Pull Request ke `main`.

# Biznet Workforce Activity

Aplikasi "Biznet Workforce Activity" adalah sebuah platform mobile yang dirancang khusus untuk internal tim teknisi Biznet. Aplikasi ini bertujuan untuk mempermudah pencatatan, pengelolaan, dan pemantauan aktivitas harian teknisi di lapangan secara efisien dan transparan. Semua data aktivitas disimpan secara real-time di Cloud Firestore, memungkinkan manajemen dan tim teknisi untuk mengakses informasi terkini dari berbagai lokasi.

## Fitur Utama

Aplikasi ini menyediakan fitur-fitur esensial untuk mendukung operasional harian tim teknisi:

### 1. **Manajemen Aktivitas Harian (CRUD)**
   Pengguna (teknisi) dapat dengan mudah **menambah**, **mengedit**, **menghapus**, dan **menandai aktivitas selesai**. Setiap aktivitas memiliki detail sebagai berikut:
   - **Judul:** Judul singkat aktivitas.
   - **Deskripsi:** Penjelasan detail mengenai pekerjaan yang dilakukan.
   - **Lokasi:** Alamat spesifik tempat aktivitas dilakukan.
   - **Long & Lat (Longitude & Latitude):** Posisi geografis perangkat saat aktivitas disimpan atau diedit. Ini diambil secara otomatis untuk memastikan akurasi lokasi pekerjaan.
   - **Jam Mulai & Jam Selesai:** Rentang waktu pelaksanaan aktivitas.
   - **Status:** Status terkini aktivitas (misalnya: Belum Selesai, Selesai, Dibatalkan).
   - **Prioritas:** Tingkat kepentingan aktivitas (misalnya: Rendah, Sedang, Tinggi).
   - **Timestamp Created & Updated:** Catatan waktu kapan aktivitas dibuat dan terakhir diperbarui.

### 2. **Pencatatan Posisi Geografis Otomatis**
   Setiap kali teknisi menyimpan atau mengedit detail aktivitas, aplikasi secara otomatis akan **mengambil dan menyimpan posisi geografis (longitude & latitude)** dari perangkat saat itu. Fitur ini sangat krusial untuk verifikasi lokasi kerja dan pemantauan pergerakan tim.

### 3. **Penyimpanan Data Berbasis Cloud (Cloud Firestore)**
   Semua data aktivitas disimpan dan diakses secara real-time melalui **Google Cloud Firestore**. Keunggulan penggunaan Cloud Firestore meliputi:
   - **Akses Real-time:** Manajemen dan teknisi dapat melihat update aktivitas secara instan.
   - **Skalabilitas:** Mampu menangani volume data yang besar seiring pertumbuhan tim dan aktivitas.
   - **Offline Support:** Data dapat diakses bahkan saat tidak ada koneksi internet, dan akan disinkronkan saat koneksi kembali tersedia.
   - **Sinkronisasi Multi-perangkat:** Memastikan semua data konsisten di berbagai perangkat dan platform.

### 4. **Antarmuka Pengguna (UI) yang Sederhana & Responsif**
   Aplikasi dirancang dengan antarmuka pengguna yang **bersih, intuitif, dan responsif**, mengikuti gaya dan panduan warna Biznet untuk pengalaman pengguna yang kohesif. Desain ini memastikan aplikasi mudah digunakan oleh teknisi di lapangan, bahkan dalam kondisi yang berbeda.

## Teknologi yang Digunakan

- **Bahasa Pemrograman:** Dart
- **Framework:** Flutter
- **State Management:** GetX
- **Database:** Google Cloud Firestore
- **Geolokasi:** `geolocator` package
- **Manajemen Waktu:** `intl` package

## Cara Menjalankan Proyek

1.  **Clone Repository:**
    ```bash
    git clone [URL_REPO_ANDA]
    cd biznet_workforce_activity
    ```
2.  **Instal Dependensi:**
    ```bash
    flutter pub get
    ```
3.  **Konfigurasi Firebase:**
    -   Buat proyek di [Firebase Console](https://console.firebase.google.com/).
    -   Tambahkan aplikasi Android dan iOS ke proyek Firebase Anda.
    -   Unduh `google-services.json` (untuk Android) dan `GoogleService-Info.plist` (untuk iOS) dan letakkan di direktori yang sesuai.
    -   Jalankan `flutterfire configure` di root proyek untuk menginisialisasi Firebase di Flutter.
    -   Pastikan aturan keamanan Cloud Firestore Anda mengizinkan baca/tulis untuk pengembangan (ubah ke aturan yang lebih ketat di produksi).
4.  **Jalankan Aplikasi:**
    ```bash
    flutter run
    ```

## Panduan Desain (Ikon & Warna)

Aplikasi ini menggunakan skema warna dan ikon yang terinspirasi dari panduan visual Biznet untuk menjaga konsistensi merek.
- **Warna Primer:** Biru Biznet
- **Warna Aksen:** Oranye/Kuning (sesuai branding Biznet)
- **Ikon:** Menggunakan ikon yang jelas dan familiar untuk fungsi-fungsi utama.

## Kontribusi

Kontribusi sangat dihargai. Silakan buat pull request atau buka isu untuk saran dan perbaikan.
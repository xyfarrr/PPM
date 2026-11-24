# Project UTS Pemrograman Mobile - Activity Counter (MVVM)

Aplikasi mobile sederhana berbasis **Flutter** untuk mencatat dan menghitung frekuensi aktivitas harian dengan menerapkan pola arsitektur **Model-View-ViewModel (MVVM)** yang dilengkapi dengan layer **Repository** dan **Data**.

---

## Identitas Mahasiswa
* **Nama:** Siti Farda Sya'bani
* **NIM:** 20240040109
* **Kelas:** TI 24 M
* **Mata Kuliah:** Pemrograman Perangkat Mobile (UTS)
* **Dosen Pengampu:** Yulhan Wahyudin

---

## Deskripsi & Fitur Aplikasi
Aplikasi ini memiliki 3 halaman utama dengan fitur interaktif sebagai berikut
1. **Halaman Home (Daftar Aktivitas):** Menampilkan daftar aktivitas beserta nilai counter, ringkasan total aktivitas, tombol tambah aktivitas baru, serta akses cepat ke halaman edit dan detail.
2. **Halaman Tambah/Edit Aktivitas:** Menyediakan form input nama aktivitas dengan validasi agar nama tidak boleh kosong serta fitur pengubahan nama aktivitas.
3. **Halaman Detail Aktivitas:** Menyediakan kontrol penghitung meliputi tombol tambah (`+`), tombol kurang (`-`) dengan batas minimum `0`, tombol `Reset` dengan dialog konfirmasi, dan tombol hapus aktivitas dengan dialog konfirmasi serta umpan balik `SnackBar`.

---

## Struktur Folder Project
```text
lib/
├── main.dart
├── models/
│   └── activity_model.dart
├── data/
│   └── activity_data.dart
├── repositories/
│   └── activity_repository.dart
├── viewmodels/
│   └── activity_viewmodel.dart
└── views/
    ├── home_view.dart
    ├── activity_form_view.dart
    └── activity_detail_view.dart

---
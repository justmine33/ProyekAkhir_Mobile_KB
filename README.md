# PenguinApp: Prediksi Spesies Penguin 🐧❄️
## Anggota Kelompok B4 👥
- **Putri Jasmine H** - 2309106051 
- **Nayla Zeanlita Putri** - 2309106052  
- **Imro Atul Wahidah** - 2309106058 
- **Octavia Ramadhani** - 2309106064

## Deskripsi Proyek 📝
**Penguin App** adalah aplikasi prediksi spesies penguin berbasis **Machine Learning** yang menggunakan **Random Forest Classifier**. Aplikasi ini menerima input pengukuran fisik penguin (panjang paruh, kedalaman paruh, panjang sirip, dan berat badan) lalu memprediksi spesiesnya:

- **Adélie** 🐧
- **Chinstrap** 🐧
- **Gentoo** 🐧

Model dilatih menggunakan **Palmer Penguins Dataset** dan mencapai **akurasi 98.7%** pada data uji.

## Tujuan Aplikasi 🎯
- Membantu identifikasi spesies penguin secara otomatis dari data morfologi.
- Menjadi contoh penerapan **Random Forest** dalam klasifikasi biologi.
- Menyediakan antarmuka mobile yang ramah pengguna via **Flutter**.

## Teknologi yang Digunakan 🖥️
| Komponen | Teknologi |
|--------|-----------|
| **Backend** | Django REST Framework 🐍 |
| **Frontend** | Flutter (Android/iOS/Web) 📱 |
| **Model ML** | Random Forest Classifier (scikit-learn) 🌳 |
| **Dataset** | [Palmer Penguins]🐧 |
| **Testing** | Postman, Flutter DevTools 🚀 |

---

## Kendala yang Dihadapi ⚠️
| Persentase | Kendala |
|-----------|--------|
| **60%** | **Proses build Flutter** (error dependency, platform channel, release mode) |
| **20%** | Integrasi endpoint Django ke Flutter (CORS, JSON parsing) |
| **10%** | Training & tuning Random Forest (hyperparameter, feature scaling) |
| **7%** | Penanganan input kosong / invalid di form Flutter |
| **3%** | Motivasi tim (malas build ulang wkwk) 😅 |

---

## Cara Menjalankan Program ⚙️
*(Penguin App – Prediksi Spesies Penguin)*

### 1. Clone Repository
```bash
git clone https://github.com/justmine33/ProyekAkhir_Mobile_KB.git
cd ProyekAkhir_Mobile_KB
```

### 2. Setup Backend (Django)
```bash
cd api/synapse
python -m venv venv

# Windows
venv\Scripts\activate

# Linux/Mac
source venv/bin/activate

# Run server
python manage.py runserver
```


### 3. Setup Frontend (Flutter)
```bash
cd ../../mobileapp
flutter pub get
flutter run
```

## 💻 Cara Penggunaan

### 1. Registrasi Akun

1. Buka aplikasi
2. Pilih **"Daftar"**
3. Isi form registrasi:
   - Nama
   - Email
   - Password
4. Klik **Daftar**

### 2. Login

1. Masukkan email & password
2. Klik **Login**
3. Jika lupa password → klik **"Lupa Password"**

### 3. Prediksi Spesies

1. Navigasi ke halaman **Predict**
2. Masukkan data pengukuran penguin:

| Parameter | Satuan | Contoh |
|-----------|--------|--------|
| Culmen Length | mm | 39.1 |
| Culmen Depth | mm | 18.7 |
| Flipper Length | mm | 181 |
| Body Mass | gram | 3750 |
| Jenis Kelamin | - | Betina |

3. Klik **Predict**
4. Tunggu 1-2 detik untuk hasil

## 📥 Download Aplikasi

**Android APK**: [Download di sini](https://drive.google.com/file/d/1R9b1Zb7e-OQVbAAS9vTdMR4r2Bm9_PiM/view?usp=sharing)


### 4. Hasil Prediksi

Aplikasi akan menampilkan:
- ✅ Spesies yang diprediksi
- 📸 Foto spesies penguin
- 📝 Ringkasan data input

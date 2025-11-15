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

### 1. Clone & Setup
```bash
git clone https://github.com/justmine33/ProyekAkhir_Mobile_KB.git
cd ProyekAkhir_Mobile_KB

### 2. Setup Backend (Django)
```bash
cd api\synapse
python -m venv venv
conda activate PA_Mobile
python manage.py runserver

### 3. Setup Frontend
```bash
cd ../mobileapp
flutter pub get

### 4. Jalankan App
```bash
flutter run


## Cara Menggunakan Aplikasi 🧑‍💻  
*(Penguin AI – Prediksi Spesies Penguin)*

1. **Registrasi Akun**  
   Buka aplikasi → pilih **“Daftar”** → isi:  
   - Nama  
   - Password 
   Tekan **Daftar** → akun langsung aktif.

2. **Login Akun**  
   Masuk dengan email & password yang sudah didaftarkan.  
   *Lupa password?* → Klik **“Lupa Password”** untuk reset via email.

3. **Halaman Predict**  
   Masukkan **pengukuran fisik penguin** (dalam milimeter & gram):  
   - **Culmen Length (Panjang Paruh)** → contoh: `39.1`  
   - **Culmen Depth (Kedalaman Paruh)** → contoh: `18.7`  
   - **Flipper Length (Panjang Sirip)** → contoh: `181`  
   - **Body Mass (Berat Badan)** → contoh: `3750`
   - **Jenis Kelamin** → contoh: `Betina`  
   Tekan **Predict** → tunggu 1–2 detik.

4. **Lihat Hasil Prediksi**  
   Aplikasi menampilkan:  
   - **Spesies Terprediksi**: `Adélie` / `Chinstrap` / `Gentoo`  
   - **Foto Species Penguin**: `98%`  
   - **Data Input**

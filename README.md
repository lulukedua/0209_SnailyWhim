# 🐌 SnailyWhim

![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?style=flat-square&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.10+-0175C2?style=flat-square&logo=dart)
![Supabase](https://img.shields.io/badge/Supabase-Backend-3ECF8E?style=flat-square&logo=supabase)
![License](https://img.shields.io/badge/License-Private-red?style=flat-square)
![Platform](https://img.shields.io/badge/Platform-Android-green?style=flat-square)

SnailyWhim is a Flutter-based mobile application designed to provide an engaging and seamless user experience through modern UI design, real-time backend integration, and personalized content management. The application leverages Supabase as its backend service and adopts scalable state management using BLoC architecture.

---

## Detail Pengembang
> **Nama**: Lu'lu' Luthfiah <br>
> **NIM**: 20230140209 <br>
> **Mata Kuliah**: Pengembangan Aplikasi Mobile Lanjut (PAML)
---

## Product Requirement Document (PRD)

### Problem Statement

Proses pemesanan bunga pada florist umumnya masih dilakukan melalui chat atau media sosial, sehingga sering menimbulkan kendala seperti keterlambatan respons, kesalahan pencatatan pesanan, kesulitan memantau stok produk, serta minimnya transparansi terhadap status pesanan pelanggan.

Di sisi pengelola bisnis, pengelolaan produk, kategori, stok, dan pesanan yang dilakukan secara manual juga berpotensi menyebabkan ketidaksesuaian data dan menurunkan efisiensi operasional.

Oleh karena itu, diperlukan sebuah aplikasi mobile yang mampu menyediakan proses pemesanan bunga secara digital, terintegrasi, dan real-time untuk meningkatkan pengalaman pelanggan sekaligus mempermudah pengelolaan bisnis florist.

---

### Proposed Solution

SnailyWhim merupakan aplikasi mobile berbasis Flutter yang dirancang untuk memfasilitasi proses pemesanan produk florist secara digital. Aplikasi ini mengintegrasikan layanan Supabase sebagai backend utama untuk mengelola autentikasi, database, penyimpanan file, serta sinkronisasi data secara real-time.

Melalui aplikasi ini, pelanggan dapat melakukan pencarian produk, menambahkan produk ke keranjang, melakukan checkout, memilih jadwal pengambilan (pickup), melakukan pembayaran, serta memantau status pesanan secara langsung. Sementara itu, administrator dapat mengelola produk, kategori, stok, dan pesanan melalui sistem yang terpusat.

---

### Feature List

#### User Features

* Registrasi dan Login Akun
* Melihat Katalog Produk Florist
* Pencarian dan Filter Produk
* Melihat Detail Produk
* Menambahkan Produk ke Keranjang
* Mengelola Keranjang Belanja
* Checkout dan Pembuatan Pesanan
* Pemilihan Cabang Pickup
* Penjadwalan Pickup Pesanan
* Pembayaran Pesanan
* Melihat Riwayat Pesanan
* Melacak Status Pesanan Secara Real-time
* Push Notification Perubahan Status Pesanan
* Manajemen Profil Pengguna

#### Admin Features

* Login Admin
* Dashboard Monitoring
* Manajemen Produk (CRUD)
* Manajemen Kategori (CRUD)
* Manajemen Stok Produk
* Manajemen Pesanan
* Pembaruan Status Pesanan
* Monitoring Pembayaran

#### Technical Features

* Supabase Authentication
* PostgreSQL Database
* Supabase Storage
* Supabase Realtime
* State Management menggunakan BLoC
* Repository Pattern
* Infinite Pagination
* Local Storage
* Push Notification
* Responsive UI

---

### Weekly Development Progress

#### Week 1 — Backend & Database Setup

**Objectives**

* Menyiapkan fondasi backend aplikasi.

**Activities**

* Konfigurasi proyek Flutter dan Supabase
* Perancangan Entity Relationship Diagram (ERD)
* Implementasi database PostgreSQL
* Pembuatan tabel dan relasi data
* Konfigurasi Supabase Authentication
* Konfigurasi Row Level Security (RLS)
* Setup Supabase Storage

**Deliverables**

* Backend siap digunakan dan terhubung dengan aplikasi.

---

#### Week 2 — Data Layer & State Management

**Objectives**

* Mengimplementasikan arsitektur aplikasi dan alur data.

**Activities**

* Pembuatan Data Models
* Implementasi Remote Data Sources
* Implementasi Repository Pattern
* Implementasi BLoC Architecture
* Pembuatan Events dan States
* Integrasi Supabase dengan Repository
* Implementasi Authentication Flow

**Deliverables**

* Struktur aplikasi modular dan scalable dengan alur data yang terorganisasi.

---

#### Week 3 — User Interface Development

**Objectives**

* Mengembangkan tampilan aplikasi berdasarkan kebutuhan pengguna.

**Activities**

* Implementasi Splash Screen
* Implementasi Authentication Pages
* Implementasi Home & Product Catalog
* Implementasi Product Detail
* Implementasi Cart Page
* Implementasi Checkout Page
* Implementasi Order History
* Implementasi Profile Page
* Integrasi UI dengan BLoC
* Implementasi Loading, Error, dan Empty State

**Deliverables**

* Seluruh halaman utama aplikasi dapat digunakan dan terintegrasi dengan backend.

---

#### Week 4 — Feature Integration & Testing

**Objectives**

* Menyempurnakan fitur dan memastikan aplikasi berjalan stabil.

**Activities**

* Integrasi Push Notification
* Implementasi Local Storage
* Implementasi Infinite Pagination
* Pengujian Fungsionalitas
* Bug Fixing
* Optimasi Performa
* Finalisasi Asset dan Branding
* Persiapan Release Build

**Deliverables**

* Aplikasi siap digunakan dan memenuhi kebutuhan pengguna serta administrator.

---


## 🛠 Tech Stack

### Framework & Language

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge\&logo=flutter\&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge\&logo=dart\&logoColor=white)

### State Management

![Flutter Bloc](https://img.shields.io/badge/Flutter_BLoC-02569B?style=for-the-badge\&logo=flutter\&logoColor=white)
![Provider](https://img.shields.io/badge/Provider-4285F4?style=for-the-badge\&logo=google\&logoColor=white)

### Backend & Database

![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge\&logo=supabase\&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge\&logo=postgresql\&logoColor=white)

### Notifications

![Flutter Local Notifications](https://img.shields.io/badge/Local_Notifications-FF9800?style=for-the-badge\&logo=android\&logoColor=white)
![App Badge](https://img.shields.io/badge/App_Badge-4CAF50?style=for-the-badge)

### Storage

![Shared Preferences](https://img.shields.io/badge/Shared_Preferences-607D8B?style=for-the-badge)

### UI & Utilities

![Flutter SVG](https://img.shields.io/badge/Flutter_SVG-02569B?style=for-the-badge\&logo=flutter\&logoColor=white)
![Lucide Icons](https://img.shields.io/badge/Lucide_Icons-F56565?style=for-the-badge)
![Infinite Pagination](https://img.shields.io/badge/Infinite_Pagination-7B61FF?style=for-the-badge)
![URL Launcher](https://img.shields.io/badge/URL_Launcher-00C853?style=for-the-badge)
![WebView](https://img.shields.io/badge/WebView-2196F3?style=for-the-badge)
![Image Picker](https://img.shields.io/badge/Image_Picker-FF5722?style=for-the-badge)

### Development Tools

![Android Studio](https://img.shields.io/badge/Android_Studio-3DDC84?style=for-the-badge\&logo=androidstudio\&logoColor=white)
![VS Code](https://img.shields.io/badge/VS_Code-007ACC?style=for-the-badge\&logo=visualstudiocode\&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge\&logo=git\&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge\&logo=github\&logoColor=white)


---

## Project Structure

```text
lib/
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   ├── services/
│   └── widgets/
│
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
│
├── bloc/
│   ├── auth/
│   ├── user/
│   ├── notification/
│   └── content/
│
├── providers/
│
├── screens/
│   ├── auth/
│   ├── onboarding/
│   ├── dashboard/
│   ├── profile/
│   └── settings/
│
├── routes/
│
├── app.dart
└── main.dart
```

---

## 🚀 Getting Started

### Prerequisites

Before running this project, ensure you have:

* Flutter SDK 3.10+
* Dart SDK
* Android Studio / VS Code
* Android SDK

Check installation:

```bash
flutter doctor
```

---

## 📦 Installation

Clone repository:

```bash
git clone https://github.com/your-username/snailywhim.git
```

Navigate to project folder:

```bash
cd snailywhim
```

Install dependencies:

```bash
flutter pub get
```

---

## ⚙ Environment Configuration

Create a `.env` file in the root project:

```env
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

---

## ▶ Running the Application

Debug mode:

```bash
flutter run
```

Specific device:

```bash
flutter run -d emulator-5554
```

---

## 🏗 Build Release

### Android APK

```bash
flutter build apk --release
```

### Android App Bundle

```bash
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

---

## 🧪 Testing

Run unit and widget tests:

```bash
flutter test
```

---

## 📚 State Management

The application uses a hybrid state management approach:

### BLoC

Used for:

* Authentication
* User Session
* Notifications
* Business Logic

### Provider

Used for:

* Lightweight UI State
* Theme Management
* Temporary Application States

---

## 🔐 Backend Architecture

SnailyWhim utilizes Supabase services:

* Authentication
* PostgreSQL Database
* Storage
* Realtime Services

---

## 👨‍💻 Development Team

Developed using Flutter and Supabase.

---

## 📄 License

This project is intended for educational and development purposes.

All rights reserved.

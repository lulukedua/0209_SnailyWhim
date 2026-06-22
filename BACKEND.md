# SnailyWhim — Backend Documentation

Dokumentasi ini menjelaskan seluruh arsitektur backend aplikasi **SnailyWhim**, sebuah aplikasi transaksi dan pemesanan florist berbasis Flutter yang menggunakan **Supabase** sebagai Backend-as-a-Service. Dokumentasi mencakup skema database, autentikasi, keamanan data (RLS), penyimpanan gambar produk, integrasi pembayaran Midtrans, realtime order tracking, dan API yang digunakan aplikasi.

---

## Daftar Isi

- [Teknologi](#teknologi)
- [Struktur Peran Pengguna](#struktur-peran-pengguna)
- [Skema Database](#skema-database)
  - [Tipe ENUM](#tipe-enum)
  - [Tabel Profil Pengguna](#tabel-profil-pengguna)
  - [Tabel Cabang](#tabel-cabang)
  - [Tabel Kategori](#tabel-kategori)
  - [Tabel Produk](#tabel-produk)
  - [Tabel Pesanan](#tabel-pesanan)
- [Autentikasi](#autentikasi)
- [Row Level Security (RLS)](#row-level-security-rls)
- [Storage Buckets](#storage-buckets)
- [Realtime Services](#realtime-services)
- [Integrasi Midtrans](#integrasi-midtrans)
- [Referensi API Endpoint](#referensi-api-endpoint)

---

## Teknologi

| Komponen | Teknologi |
| :--- | :--- |
| Backend Platform | Supabase |
| Database | PostgreSQL |
| Authentication | Supabase Auth |
| Storage | Supabase Storage |
| Realtime | Supabase Realtime |
| Payment Gateway | Midtrans Snap |
| Push Notification | Firebase Cloud Messaging |
| Client | Flutter (Dart) |

---

## Struktur Peran Pengguna

Aplikasi SnailyWhim memiliki dua peran utama.

| Peran | Keterangan |
| :--- | :--- |
| `admin` | Mengelola produk, kategori, stok, dan pesanan |
| `user` | Melakukan pemesanan dan pembayaran produk |

Role pengguna disimpan pada tabel `profile.role` dan digunakan untuk menentukan hak akses pada aplikasi.

---

# Skema Database

## Tipe ENUM

### Role Pengguna

```sql
CREATE TYPE role_type AS ENUM (
  'admin',
  'user'
);
```

### Status Order

```sql
CREATE TYPE status_order AS ENUM (
  'waiting',
  'process',
  'selesai',
);
```

---

## Tabel Profil Pengguna

Data profil pengguna dipisahkan dari Supabase Auth.

### public.profile

| Kolom | Tipe | Keterangan |
| :--- | :--- | :--- |
| id | UUID | PK, FK → auth.users(id) |
| nama | TEXT | Nama pengguna |
| image_url | TEXT | URL foto profil |
| role | role_type | Role pengguna |
| cabang_id | UUID | FK → cabang(id) |
| created_at | TIMESTAMPTZ | Waktu dibuat |
| updated_at | TIMESTAMPTZ | Waktu diperbarui |

### Relasi

- Satu profile dimiliki satu akun auth.
- Admin dapat terhubung dengan satu cabang tertentu.

---

## Tabel Cabang

### public.cabang

| Kolom | Tipe | Keterangan |
| :--- | :--- | :--- |
| id | UUID | Primary Key |
| nama_cabang | TEXT | Nama cabang florist |
| alamat | TEXT | Alamat cabang |
| kota | TEXT | Kota cabang |
| created_at | TIMESTAMPTZ | Waktu dibuat |
| updated_at | TIMESTAMPTZ | Waktu diperbarui |

### Relasi

- Satu cabang memiliki banyak produk.
- Satu cabang dapat memiliki beberapa admin.

---

## Tabel Kategori

### public.kategori

| Kolom | Tipe | Keterangan |
| :--- | :--- | :--- |
| id | UUID | Primary Key |
| nama_kategori | TEXT | Nama kategori produk |
| created_at | TIMESTAMPTZ | Waktu dibuat |
| updated_at | TIMESTAMPTZ | Waktu diperbarui |

### Relasi

- Satu kategori memiliki banyak produk.

---

## Tabel Produk

### public.product

| Kolom | Tipe | Keterangan |
| :--- | :--- | :--- |
| id | UUID | Primary Key |
| nama_product | TEXT | Nama produk |
| deskripsi | TEXT | Deskripsi produk |
| harga | INTEGER | Harga produk |
| stok | SMALLINT | Stok tersedia |
| image_url | TEXT | URL gambar produk |
| kategori_id | UUID | FK → kategori(id) |
| cabang_id | UUID | FK → cabang(id) |
| created_at | TIMESTAMPTZ | Waktu dibuat |
| updated_at | TIMESTAMPTZ | Waktu diperbarui |

### Relasi

- Produk berada dalam satu kategori.
- Produk tersedia pada satu cabang.

---

## Tabel Pesanan

### public.order

| Kolom | Tipe | Keterangan |
| :--- | :--- | :--- |
| id | UUID | Primary Key |
| user_id | UUID | FK → profile(id) |
| total_harga | BIGINT | Total pembayaran |
| status_order | status_order_type | Status pesanan |
| status_pembayaran | VARCHAR | Status pembayaran Midtrans |
| payment_type | VARCHAR | Metode pembayaran |
| item | JSONB | Snapshot item pesanan |
| snap_token | VARCHAR | Token Midtrans |
| midtrans_order_id | VARCHAR | ID transaksi Midtrans |
| created_at | TIMESTAMPTZ | Waktu dibuat |
| updated_at | TIMESTAMPTZ | Waktu diperbarui |

### Relasi

- Satu user dapat memiliki banyak pesanan.
- Setiap pesanan menyimpan snapshot produk pada saat checkout.

---

## Autentikasi

Autentikasi menggunakan Supabase Auth berbasis Email dan Password.

### Register

1. User mengisi form registrasi.
2. Supabase membuat akun pada `auth.users`.
3. Trigger membuat data pada tabel `profile`.
4. Session JWT diterbitkan.

### Login

1. User memasukkan email dan password.
2. Supabase memverifikasi kredensial.
3. JWT dikembalikan ke aplikasi.
4. Session aktif digunakan untuk seluruh request berikutnya.

---

## Row Level Security (RLS)

### Ringkasan Hak Akses

| Tabel | Admin | User |
| :--- | :---: | :---: |
| profile | CRUD | Read & Update sendiri |
| cabang | CRUD | Read |
| kategori | CRUD | Read |
| product | CRUD | Read |
| order | CRUD | CRUD milik sendiri |

---

## Storage Buckets

### product-images

Menyimpan gambar produk florist.

**Path Convention**

```text
products/{product_id}/{filename}
```

### profile-images

Menyimpan foto profil pengguna.

```text
profiles/{user_id}/{filename}
```

---

## Realtime Services

Supabase Realtime digunakan untuk:

- Update status pesanan
- Sinkronisasi stok produk
- Monitoring pembayaran

Client melakukan subscribe terhadap perubahan tabel:

```text
order
product
```

---

## Integrasi Midtrans

### Payment Flow

```text
Checkout
   │
   ▼
Create Order
   │
   ▼
Generate Snap Token
   │
   ▼
Midtrans Snap
   │
   ▼
Payment Success
   │
   ▼
Update Order
```

### Status Pembayaran

- pending
- settlement
- capture
- expire
- cancel
- deny

---

## Referensi API Endpoint

### Authentication

| Method | Endpoint | Keterangan |
| :--- | :--- | :--- |
| POST | /auth/v1/signup | Registrasi pengguna |
| POST | /auth/v1/token | Login |
| POST | /auth/v1/logout | Logout |

### Products

| Method | Endpoint |
| :--- | :--- |
| GET | /rest/v1/product |
| POST | /rest/v1/product |
| PATCH | /rest/v1/product |
| DELETE | /rest/v1/product |

### Orders

| Method | Endpoint |
| :--- | :--- |
| GET | /rest/v1/order |
| POST | /rest/v1/order |
| PATCH | /rest/v1/order |

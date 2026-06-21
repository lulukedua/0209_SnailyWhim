class AppErrorMessage {
  static String from(Object error) {
    final message = error.toString().toLowerCase();

    if (message.contains('invalid login credentials')) {
      return 'Email atau password yang kamu masukkan salah.';
    }

    if (message.contains('user already registered')) {
      return 'Email sudah terdaftar. Silakan login menggunakan akun tersebut.';
    }

    if (message.contains('email not confirmed')) {
      return 'Silakan verifikasi email terlebih dahulu.';
    }

    if (message.contains('unable to validate email')) {
      return 'Masukkan alamat email yang valid.';
    }

    if (message.contains('password')) {
      return 'Password minimal 6 karakter.';
    }

    if (message.contains('duplicate key')) {
      return 'Data tersebut sudah tersedia.';
    }

    if (message.contains('row-level security')) {
      return 'Kamu tidak memiliki izin melakukan aksi ini.';
    }

    if (message.contains('socketexception')) {
      return 'Tidak ada koneksi internet.';
    }

    if (message.contains('timeout')) {
      return 'Permintaan melebihi batas waktu. Silakan coba lagi.';
    }

    return 'Terjadi kesalahan. Silakan coba lagi.';
  }
}
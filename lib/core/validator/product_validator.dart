class ProductValidator {
  static String? validateNama(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Nama produk wajib diisi";
    }

    final regex = RegExp(r'^[A-Z][a-zA-Z]*(\s[A-Z][a-zA-Z]*)*$');

    if (!regex.hasMatch(value.trim())) {
      return "Contoh: Buket Mawar";
    }

    return null;
  }

  static String? validateDeskripsi(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Deskripsi wajib diisi";
    }

    return null;
  }

  static String? validateHarga(String? value) {
    if (value == null || value.isEmpty) {
      return "Harga wajib diisi";
    }

    final harga = int.tryParse(value);

    if (harga == null) {
      return "Harga harus berupa angka";
    }

    if (harga <= 0) {
      return "Harga harus lebih dari 0";
    }

    return null;
  }

  static String? validateStok(String? value) {
    if (value == null || value.isEmpty) {
      return "Stok wajib diisi";
    }

    final stok = int.tryParse(value);

    if (stok == null) {
      return "Stok harus berupa angka";
    }

    if (stok < 0) {
      return "Stok tidak boleh minus";
    }

    return null;
  }
}

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String nama;
  final String role;
  final String? imageUrl;
  final String? cabangId;

  const UserModel({
    required this.id,
    required this.email,
    required this.nama,
    required this.role,
    this.imageUrl,
    this.cabangId,
  });

  bool get isAdmin => role == 'admin';
  bool get isUser => role == 'user';

  @override
  List<Object?> get props => [id, email, nama, role, imageUrl, cabangId];
}
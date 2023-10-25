import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.role,
    this.profilePic,
  });

  const LocalUser.empty()
      : id = '',
        email = '',
        username = '',
        name = '',
        role = '',
        profilePic = '';

  final String id;
  final String email;
  final String username;
  final String name;
  final String role;
  final String? profilePic;

  @override
  List<Object?> get props => [id, email, username];

  @override
  String toString() {
    return 'LocalUser{id: $id, email: $email, username: $username,'
        ' role: $role, name: $name, profilePic: $profilePic}';
  }
}

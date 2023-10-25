import 'package:clean_architecture_tdd_flutter_template/core/utils/typedef.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required String id,
    required String email,
    required String username,
    required String name,
    required String role,
    String? profilePic,
  }) : super(
          id: id,
          email: email,
          username: username,
          name: name,
          role: role,
          profilePic: profilePic,
        );

  const LocalUserModel.empty()
      : this(
          id: '',
          email: '',
          username: '',
          name: '',
          role: '',
          profilePic: '',
        );

  LocalUserModel copyWith({
    String? id,
    String? email,
    String? username,
    String? name,
    String? role,
    String? profilePic,
  }) {
    return LocalUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      role: role ?? this.role,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  LocalUserModel.fromMap(DataMap map)
      : super(
          id: map['id'] as String,
          email: map['email'] as String,
          username: map['username'] as String,
          name: map['name'] as String,
          role: map['role'] as String,
          profilePic: map['profilePic'] as String?,
        );

  DataMap toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'name': name,
      'role': role,
      'profilePic': profilePic,
    };
  }
}

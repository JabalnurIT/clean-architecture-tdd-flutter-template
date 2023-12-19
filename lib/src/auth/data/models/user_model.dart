import '../../../../core/utils/typedef.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.role,
    super.profileImg,
    super.location,
  });

  const UserModel.empty()
      : this(
          id: 1,
          email: 'testing@admin.com',
          name: 'testing',
          role: 'employee',
          profileImg: null,
          location: null,
        );

  UserModel copyWith({
    int? id,
    String? email,
    String? name,
    String? role,
    String? profileImg,
    String? location,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      profileImg: profileImg ?? this.profileImg,
      location: location ?? this.location,
    );
  }

  UserModel.fromMap(DataMap map)
      : super(
          id: map['id'] as int,
          email: map['email'] as String,
          name: map['name'] as String,
          role: map['role'] as String,
          profileImg: map['profile_img'] as String?,
          location: map['location'] as String?,
        );

  DataMap toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'profile_img': profileImg,
      'location': location,
    };
  }
}

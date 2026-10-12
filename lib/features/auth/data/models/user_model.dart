class UserModel {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String? role;
  final String avatar;
  final String? creationAt;
  final String? updatedAt;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.role,
    required this.avatar,
    this.creationAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      avatar: json['avatar'],
      creationAt: json['creationAt'],
      updatedAt: json['updatedAt'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password, 'avatar': avatar};
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? avatar,
    String? role,

    String? creationAt,
    String? updatedAt,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
      creationAt: creationAt ?? this.creationAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

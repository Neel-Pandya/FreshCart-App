class UserModel {
  final String id;
  final String name;
  final String email;
  final int role;
  final String accessToken;
  final String? profile;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.accessToken,
    this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    role: json['role'] ?? 0,
    accessToken: json['accessToken'] ?? '',
    profile: json['profile'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'email': email,
    'role': role,
    'accessToken': accessToken,
  };
}

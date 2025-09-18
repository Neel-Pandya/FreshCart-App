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
    id: json['data']['_id'],
    name: json['data']['name'],
    email: json['data']['email'],
    role: json['data']['role'],
    accessToken: json['data']['accessToken'],
    profile: json['data']['profile'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'email': email,
    'role': role,
    'accessToken': accessToken,
  };
}

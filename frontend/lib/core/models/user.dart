class User {
  final String id;
  final String name;
  final String email;
  final int? role;
  final String? status;
  final String imageUrl;
  final String accessToken;
  final bool isGoogle;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    this.status = 'inactive',
    required this.accessToken,
    this.role,
    this.isGoogle = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      status: json['status'],
      imageUrl: json['profile'] ?? '',
      accessToken: json['accessToken'],
      isGoogle: json['isGoogle'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'status': status,
      'profile': imageUrl,
      'accessToken': accessToken,
      'isGoogle': isGoogle,
    };
  }
}

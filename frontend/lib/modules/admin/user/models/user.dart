class User {
  final String userId;
  final String name;
  final String email;
  final int? role;
  final String? status;
  final String imageUrl;

  const User({
    required this.userId,
    required this.name,
    required this.email,
    required this.imageUrl,
    this.status = 'inactive',
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['_id'],
      name: json['name'],
      email: json['email'],
      role: json['role'] ?? 0,
      status: json['status'],
      imageUrl: json['profile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'role': role,
      'status': status,
      'profile': imageUrl,
    };
  }
}

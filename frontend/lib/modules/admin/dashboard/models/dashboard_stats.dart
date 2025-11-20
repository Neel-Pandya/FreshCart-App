class DashboardStats {
  final int totalUsers;
  final int totalProducts;
  final int totalOrders;
  final double totalPayment;

  DashboardStats({
    required this.totalUsers,
    required this.totalProducts,
    required this.totalOrders,
    required this.totalPayment,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalUsers: json['totalUsers'] ?? 0,
      totalProducts: json['totalProducts'] ?? 0,
      totalOrders: json['totalOrders'] ?? 0,
      totalPayment: (json['totalPayment'] ?? 0).toDouble(),
    );
  }
}

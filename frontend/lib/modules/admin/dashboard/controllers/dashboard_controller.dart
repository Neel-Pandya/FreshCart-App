import 'package:frontend/core/utils/api_client.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/modules/admin/dashboard/models/dashboard_stats.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final _isLoading = false.obs;
  final Rx<DashboardStats?> _stats = Rx<DashboardStats?>(null);

  bool get isLoading => _isLoading.value;
  DashboardStats? get stats => _stats.value;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardStats();
  }

  Future<void> fetchDashboardStats() async {
    try {
      _isLoading.value = true;

      final response = await apiClient.get('/users/stats/dashboard');

      if (response['success'] == true) {
        _stats.value = DashboardStats.fromJson(response['data']);
      }
    } catch (e) {
      Toaster.showErrorMessage(message: e.toString());
    } finally {
      _isLoading.value = false;
    }
  }
}

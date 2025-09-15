import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/admin/dashboard/data/analytic_data.dart';
import 'package:frontend/modules/admin/dashboard/widgets/dashboard_analytics.dart';
import 'package:frontend/modules/admin/orders/data/order_data.dart';
import 'package:frontend/modules/admin/orders/widgets/order_list_item.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: ListView(
            children: [
              SizedBox(
                height: 380,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  physics: const NeverScrollableScrollPhysics(),
                  children: analyticData
                      .map((analytic) => DashboardAnalytics(analytic: analytic))
                      .toList(),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Recent Orders',
                style: AppTypography.bodyLargeEmphasized.copyWith(color: AppColors.textPrimary),
              ),

              const SizedBox(height: 18),

              ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: orderData.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) => OrderListItem(
                  order: orderData[index],
                  imageUrl: 'assets/images/user/common_profile.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

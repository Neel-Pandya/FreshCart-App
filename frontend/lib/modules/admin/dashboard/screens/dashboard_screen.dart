import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/admin/dashboard/data/analytic_data.dart';
import 'package:frontend/modules/admin/dashboard/widgets/dashboard_analytics.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                constraints: const BoxConstraints(minHeight: 380, maxHeight: 380),

                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: analyticData.length,
                  itemBuilder: (ctx, index) => DashboardAnalytics(analytic: analyticData[index]),
                ),
              ),

              Text(
                'Recent Orders',
                style: AppTypography.bodyLargeEmphasized.copyWith(color: AppColors.textPrimary),
              ),

              const SizedBox(height: 18),

              Text(
                'No Orders Yet',
                style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/admin/dashboard/models/analytic.dart';

class DashboardAnalytics extends StatelessWidget {
  const DashboardAnalytics({super.key, required this.analytic});

  final Analytic analytic;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).brightness == Brightness.light
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
        border: Border.all(color: const Color(0xFFCAC4D0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: const EdgeInsets.all(10),
              color: analytic.iconBackground,
              child: SvgPicture.asset(
                height: 18,
                width: 18,
                analytic.iconPath,
                colorFilter: ColorFilter.mode(analytic.iconColor, BlendMode.srcIn),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            analytic.title,
            style: AppTypography.bodyLargeEmphasized.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            analytic.subtitle,
            style: AppTypography.bodyMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/routes/user_routes.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:get/get.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.imageUrl, required this.name});

  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(imageUrl, fit: BoxFit.cover, height: 50, width: 50),
          ),

          const SizedBox(width: 13),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTypography.bodyMediumEmphasized.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                'Let\'s go shopping',
                style: AppTypography.bodyMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),

          const Spacer(),

          GestureDetector(
            onTap: () {
              Get.toNamed(UserRoutes.cart);
            },
            child: Icon(FeatherIcons.shoppingBag, color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}

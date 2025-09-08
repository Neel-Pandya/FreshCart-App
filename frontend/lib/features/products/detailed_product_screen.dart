import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/widgets/primary_button_with_icon.dart';
import 'package:frontend/core/widgets/quantity_handler.dart';
import 'package:frontend/features/products/models/product.dart';

class DetailedProductScreen extends StatelessWidget {
  const DetailedProductScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detailed Product',
          style: AppTypography.titleLarge.copyWith(color: AppColors.textPrimary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FeatherIcons.shoppingBag, color: AppColors.iconColor),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(product.imageUrl, width: double.infinity, fit: BoxFit.cover, height: 300),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        style: AppTypography.titleLargeEmphasized.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFFE0E0E0).withValues(alpha: 0.35),
                          shape: const CircleBorder(),
                          fixedSize: const Size(40, 40),
                        ),
                        icon: const Icon(FeatherIcons.heart, color: AppColors.iconColor),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Text(
                    product.description,
                    style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
                  ),

                  const SizedBox(height: 15),

                  const Divider(height: 1, thickness: 1, color: AppColors.border),
                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose Quantity',
                        style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
                      ),

                      const QuantityHandler(),
                    ],
                  ),

                  const SizedBox(height: 30),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '₹ ',
                              style: AppTypography.titleLargeEmphasized.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            TextSpan(
                              text: product.price.toStringAsFixed(0),
                              style: AppTypography.titleLargeEmphasized.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      const SizedBox(
                        width: 150,
                        child: PrimaryButtonWithIcon(
                          text: 'Add To cart',
                          icon: FeatherIcons.shoppingBag,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

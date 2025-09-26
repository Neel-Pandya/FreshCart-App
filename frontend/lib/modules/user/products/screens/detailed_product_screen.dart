import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/widgets/primary_button_with_icon.dart';
import 'package:frontend/core/widgets/quantity_handler.dart';
import 'package:frontend/core/models/product.dart';
import 'package:get/get.dart';

class DetailedProductScreen extends StatelessWidget {
  const DetailedProductScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Get.theme.colorScheme;
    final iconTheme = Get.theme.iconTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detailed Product',
          style: AppTypography.titleLarge.copyWith(color: colorScheme.onSurface),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(FeatherIcons.shoppingBag, color: iconTheme.color),
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
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor: colorScheme.onSurface.withValues(alpha: 0.15),
                          shape: const CircleBorder(),
                          fixedSize: const Size(40, 40),
                        ),
                        icon: Icon(FeatherIcons.heart, color: colorScheme.onSurface),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Text(
                    product.description,
                    style: AppTypography.bodyMedium.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Divider(
                    height: 1,
                    thickness: 1,
                    color: colorScheme.onSurface.withValues(alpha: 0.2),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose Quantity',
                        style: AppTypography.titleMedium.copyWith(color: colorScheme.onSurface),
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
                              text: 'â‚¹ ',
                              style: AppTypography.titleLargeEmphasized.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                            TextSpan(
                              text: product.price.toStringAsFixed(0),
                              style: AppTypography.titleLargeEmphasized.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(
                        width: 150,
                        child: PrimaryButtonWithIcon(
                          text: 'Add To Cart',
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

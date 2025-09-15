import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/widgets/product_card.dart';
import 'package:frontend/modules/user/home/widgets/home_header.dart';
import 'package:frontend/modules/user/products/data/product_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const HomeHeader(
                name: 'Neel Pandya',
                imageUrl: 'assets/images/user/common_profile.png',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'New Arrivals 🔥',
                    style: AppTypography.bodyLargeEmphasized.copyWith(color: AppColors.textPrimary),
                  ),

                  const Spacer(),

                  Text(
                    'See All',
                    style: AppTypography.bodyMedium.copyWith(color: AppColors.primary),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: productsData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 25,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) => ProductCard(product: productsData[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

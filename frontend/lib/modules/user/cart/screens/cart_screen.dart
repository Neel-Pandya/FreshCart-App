import 'package:flutter/material.dart';
import 'package:frontend/core/routes/user_routes.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/user/cart/data/cart_data.dart';
import 'package:frontend/modules/user/cart/widgets/cart_item.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: AppTypography.titleLarge.copyWith(color: AppColors.textPrimary)),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(height: 1, thickness: 1, color: AppColors.border),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  itemCount: cartData.length,
                  itemBuilder: (context, index) => CartItem(cart: cartData[index]),
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1, thickness: 1, color: AppColors.border),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: PrimaryButton(
                text: 'Checkout',
                onPressed: () {
                  Get.toNamed(UserRoutes.checkout);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

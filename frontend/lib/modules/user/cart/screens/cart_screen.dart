import 'package:flutter/material.dart';
import 'package:frontend/core/routes/user_routes.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/user/cart/controller/cart_controller.dart';
import 'package:frontend/modules/user/cart/widgets/cart_item.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartController cartController;

  @override
  void initState() {
    super.initState();
    cartController = Get.put(CartController());
    // Fetch cart items when screen loads
    cartController.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: AppTypography.titleLarge.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          if (cartController.errorMessage.value.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cartController.errorMessage.value,
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.error),
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(text: 'Go Back', onPressed: () => Get.back()),
                  ],
                ),
              ),
            );
          }

          return cartController.isFetching.value
              ? const Center(child: CircularProgressIndicator())
              : cartController.cartItems.isEmpty
              ? const Center(child: Text('Your cart is empty'))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Divider(height: 1, thickness: 1, color: AppColors.border),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                          itemCount: cartController.cartItems.length,
                          itemBuilder: (context, index) => CartItem(
                            cart: cartController.cartItems[index],
                            onRemove: (productId) => cartController.removeFromCart(productId),
                            onQuantityChange: (productId, quantity) =>
                                cartController.updateCartQuantity(productId, quantity),
                          ),
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
                );
        }),
      ),
    );
  }
}

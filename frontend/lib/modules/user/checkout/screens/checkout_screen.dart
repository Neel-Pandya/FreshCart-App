import 'package:flutter/material.dart';
import 'package:frontend/core/routes/user_routes.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/user/cart/controller/cart_controller.dart';
import 'package:frontend/modules/user/checkout/widgets/checkout_address.dart';
import 'package:frontend/modules/user/checkout/widgets/payment_method.dart';
import 'package:frontend/modules/user/checkout/widgets/product_listing.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final CartController cartController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cartController = Get.find<CartController>();
  }

  void _handleCheckout(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    FocusManager.instance.primaryFocus?.unfocus();

    // Clear cart after successful checkout
    cartController.clearCart();

    Toaster.showSuccessMessage(message: 'Checkout successful');
    Future.delayed(const Duration(seconds: 2), () {
      if (!context.mounted) return;
      Get.offAllNamed(UserRoutes.master);
    });
  }

  double _calculateTotal() {
    if (cartController.cartItems.isEmpty) return 0;
    return cartController.cartItems.map((e) => e.totalPrice).reduce((prev, e) => prev + e);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: AppTypography.titleLarge.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () => cartController.cartItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your cart is empty',
                        style: AppTypography.titleMedium.copyWith(
                          color: Get.theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 20),
                      PrimaryButton(
                        text: 'Back to Shopping',
                        onPressed: () => Get.offAllNamed(UserRoutes.master),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Divider(height: 1, thickness: 1, color: AppColors.border),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CheckoutAddress(formKey: _formKey),
                            const SizedBox(height: 25),
                            Text(
                              'Products (${cartController.cartItems.length})',
                              style: AppTypography.titleMediumEmphasized.copyWith(
                                color: Get.theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 250,
                              child: ProductListing(cart: cartController.cartItems),
                            ),
                            const SizedBox(height: 25),
                            Text(
                              'Payment Method',
                              style: AppTypography.titleMediumEmphasized.copyWith(
                                color: Get.theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 15),
                            const PaymentMethod(),
                            const SizedBox(height: 35),
                            Row(
                              children: [
                                Text(
                                  'Total Amount',
                                  style: AppTypography.titleMediumEmphasized.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '\u20B9 ${_calculateTotal().toStringAsFixed(0)}',
                                  style: AppTypography.titleMediumEmphasized.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: PrimaryButton(
                                text: 'Checkout',
                                onPressed: () => _handleCheckout(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

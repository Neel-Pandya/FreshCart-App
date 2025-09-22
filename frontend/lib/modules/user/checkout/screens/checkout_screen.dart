import 'package:flutter/material.dart';
import 'package:frontend/core/routes/user_routes.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/user/cart/data/cart_data.dart';
import 'package:frontend/modules/user/checkout/widgets/checkout_address.dart';
import 'package:frontend/modules/user/checkout/widgets/payment_method.dart';
import 'package:frontend/modules/user/checkout/widgets/product_listing.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  void _handleCheckout(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    FocusManager.instance.primaryFocus?.unfocus();
    Toaster.showSuccessMessage(message: 'Checkout successful');
    Future.delayed(const Duration(seconds: 2), () {
      if (!context.mounted) return;
      Get.offAllNamed(UserRoutes.master);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: AppTypography.titleLarge.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
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
                      'Products (${cartData.length})',
                      style: AppTypography.titleMediumEmphasized.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 15),
                    SizedBox(height: 250, child: ProductListing(cart: cartData)),

                    const SizedBox(height: 25),
                    Text(
                      'Payment Method',
                      style: AppTypography.titleMediumEmphasized.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
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
                          '\u20B9 ${cartData.map((e) => e.productPrice).reduce((prev, e) => prev + e).toStringAsFixed(0)}',
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
    );
  }
}

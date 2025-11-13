import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:frontend/core/routes/user_routes.dart';
import 'package:frontend/core/services/razorpay_service.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/common/auth/common/controllers/auth_controller.dart';
import 'package:frontend/modules/user/cart/controller/cart_controller.dart';
import 'package:frontend/modules/user/checkout/controller/checkout_address_controller.dart';
import 'package:frontend/modules/user/checkout/widgets/checkout_address.dart';
import 'package:frontend/modules/user/checkout/widgets/payment_method.dart';
import 'package:frontend/modules/user/checkout/widgets/product_listing.dart';
import 'package:frontend/modules/user/orders/controller/order_controller.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final CartController cartController;
  late final OrderController orderController;
  late final PaymentMethodController paymentController;
  late final CheckoutAddressController addressController;
  late final AuthController authController;
  late final RazorpayService razorpayService;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cartController = Get.find<CartController>();
    orderController = Get.put(OrderController());
    paymentController = Get.put(PaymentMethodController());
    addressController = Get.put(CheckoutAddressController());
    authController = Get.find<AuthController>();
    razorpayService = RazorpayService();
  }

  @override
  void dispose() {
    razorpayService.dispose();
    super.dispose();
  }

  void _handleCheckout(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    FocusManager.instance.primaryFocus?.unfocus();

    final paymentMethod = paymentController.getSelectedMethod();

    if (paymentMethod == null) {
      Toaster.showErrorMessage(message: 'Please select a payment method');
      return;
    }

    if (paymentMethod == 'Cash on Delivery') {
      _handleCashOnDelivery();
    } else if (paymentMethod == 'RazorPay') {
      _handleRazorpayPayment();
    }
  }

  Future<void> _handleRazorpayPayment() async {
    final deliveryAddress = addressController.getDeliveryAddress();
    final user = authController.user.value;

    if (user == null) {
      Toaster.showErrorMessage(message: 'User not logged in');
      return;
    }

    // Create Razorpay order on backend
    final orderData = await orderController.createRazorpayOrder(deliveryAddress);

    if (orderData == null) {
      Toaster.showErrorMessage(message: orderController.errorMessage.value);
      return;
    }

    log('Opening Razorpay payment gateway with order: ${orderData['orderId']}');

    // Open Razorpay payment gateway
    razorpayService.openPaymentGateway(
      orderId: orderData['orderId'] as String,
      amount: orderData['amount'] as int,
      keyId: orderData['keyId'] as String,
      name: user.name,
      email: user.email,
      contact: '9999999999', // Default contact number
      onSuccess: (paymentId, orderId, signature) async {
        // Verify payment on backend
        final success = await orderController.verifyRazorpayPayment(
          razorpayOrderId: orderId,
          razorpayPaymentId: paymentId,
          razorpaySignature: signature,
          deliveryAddress: deliveryAddress,
        );

        if (!mounted) return;

        if (success) {
          // Clear cart after successful payment
          cartController.clearCart();

          Toaster.showSuccessMessage(message: 'Payment successful! Order placed.');
          Future.delayed(const Duration(seconds: 2), () {
            if (!context.mounted) return;
            Get.offAllNamed(UserRoutes.master);
          });
        } else {
          Toaster.showErrorMessage(
            message: orderController.errorMessage.value.isNotEmpty
                ? orderController.errorMessage.value
                : 'Payment verification failed',
          );
        }
      },
      onError: (errorMessage) {
        Toaster.showErrorMessage(message: errorMessage);
      },
    );
  }

  Future<void> _handleCashOnDelivery() async {
    final deliveryAddress = addressController.getDeliveryAddress();
    final paymentMethod = paymentController.getSelectedMethod() ?? 'Cash on Delivery';

    final success = await orderController.createOrder(paymentMethod, deliveryAddress);

    if (!mounted) return;

    if (success) {
      // Clear cart after successful order
      cartController.clearCart();

      Toaster.showSuccessMessage(message: 'Order placed successfully');
      Future.delayed(const Duration(seconds: 2), () {
        if (!context.mounted) return;
        Get.offAllNamed(UserRoutes.master);
      });
    } else {
      Toaster.showErrorMessage(message: orderController.errorMessage.value);
    }
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Your cart is empty',
                        textAlign: TextAlign.center,
                        style: AppTypography.titleMedium.copyWith(
                          color: Get.theme.colorScheme.onSurface,
                        ),
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
                              child: Obx(
                                () => PrimaryButton(
                                  text: orderController.isLoading.value
                                      ? 'Processing...'
                                      : 'Checkout',
                                  onPressed: orderController.isLoading.value
                                      ? null
                                      : () => _handleCheckout(context),
                                ),
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

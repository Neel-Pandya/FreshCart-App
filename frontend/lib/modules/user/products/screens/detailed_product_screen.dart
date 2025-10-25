import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/models/admin_product.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/primary_button_with_icon.dart';
import 'package:frontend/core/widgets/quantity_handler.dart';
import 'package:frontend/modules/admin/product/controller/product_controller.dart';
import 'package:frontend/modules/user/cart/controller/cart_controller.dart';
import 'package:get/get.dart';

class DetailedProductScreen extends StatefulWidget {
  const DetailedProductScreen({super.key});

  @override
  State<DetailedProductScreen> createState() => _DetailedProductScreenState();
}

class _DetailedProductScreenState extends State<DetailedProductScreen> {
  final productController = Get.find<ProductController>();
  final cartController = Get.put(CartController());
  bool isFavourite = false;
  int quantity = 1;
  late final Product product;

  @override
  void initState() {
    super.initState();
    product = Get.arguments as Product;
    isFavouriteProduct();
  }

  Future<void> isFavouriteProduct() async {
    final status = await productController.isProductFavourite(product.productId);
    setState(() {
      isFavourite = status;
    });
  }

  void handleIncrementQuantity() {
    setState(() {
      if (quantity < product.quantity) {
        quantity++;
      } else {
        Toaster.showErrorMessage(message: 'Stock limit reached!');
      }
    });
  }

  void handleDecrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  double get calculatedPrice => product.price * quantity;
  bool get isStockAvailable => quantity <= product.quantity;

  Future<void> _handleAddToCart() async {
    if (!isStockAvailable) {
      Toaster.showErrorMessage(message: 'Insufficient stock available');
      return;
    }

    final success = await cartController.addToCart(product.productId, quantity);
    if (!success) {
      Toaster.showErrorMessage(message: cartController.errorMessage.value);
      return;
    }

    Toaster.showSuccessMessage(message: cartController.responseMessage.value);
  }

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
                        onPressed: () {
                          productController.toggleFavourite(product.productId);
                          setState(() {
                            isFavourite = !isFavourite;
                          });
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: colorScheme.onSurface.withValues(alpha: 0.15),
                          shape: const CircleBorder(),
                          fixedSize: const Size(40, 40),
                        ),
                        icon: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                          color: isFavourite ? Colors.red : colorScheme.onSurface,
                        ),
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
                      QuantityHandler(
                        quantity: quantity,
                        onIncrement: handleIncrementQuantity,
                        onDecrement: handleDecrementQuantity,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '₹ ',
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
                          const SizedBox(height: 5),
                          Text(
                            'Total: ₹ ${calculatedPrice.toStringAsFixed(0)}',
                            style: AppTypography.bodyMedium.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (!isStockAvailable)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                'Stock limit exceeded!',
                                style: AppTypography.bodySmall.copyWith(color: AppColors.error),
                              ),
                            ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 150,
                        child: PrimaryButtonWithIcon(
                          text: 'Add To Cart',
                          onPressed: isStockAvailable ? _handleAddToCart : null,
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

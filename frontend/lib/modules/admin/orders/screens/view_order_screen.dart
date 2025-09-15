import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/admin/orders/models/order.dart';
import 'package:frontend/modules/admin/orders/widgets/view_order_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ViewOrderScreen extends StatefulWidget {
  const ViewOrderScreen({super.key, required this.order});
  final Order order;

  @override
  State<ViewOrderScreen> createState() => _ViewOrderScreenState();
}

class _ViewOrderScreenState extends State<ViewOrderScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.order.orderId,
          style: AppTypography.titleLarge.copyWith(color: AppColors.textPrimary),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: 300,
                      child: PageView.builder(
                        controller: _pageController,
                        itemBuilder: (context, index) =>
                            ViewOrderItem(product: widget.order.products[index]),
                        itemCount: widget.order.products.length,
                      ),
                    ),
                  ),

                  const SizedBox(height: 13),

                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: widget.order.products.length,
                      effect: const JumpingDotEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        activeDotColor: AppColors.primary,
                        dotColor: AppColors.border,
                      ),
                      onDotClicked: (page) => _pageController.animateToPage(
                        page,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ordered By - ${widget.order.orderedBy}',
                          style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'Total Amount - \u20B9 ${widget.order.totalAmount.toStringAsFixed(0)}',
                          style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

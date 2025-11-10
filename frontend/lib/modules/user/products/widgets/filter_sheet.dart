import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/widgets/drop_down_field.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/admin/category/controllers/category_controller.dart';
import 'package:frontend/modules/admin/product/controller/product_controller.dart';
import 'package:get/get.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late ProductController productController;
  late CategoryController categoryController;
  String? _selectedCategory;
  RangeValues? _priceRange;

  @override
  void initState() {
    super.initState();
    productController = Get.find<ProductController>();
    categoryController = Get.find<CategoryController>();

    // Initialize with current filter values
    _selectedCategory = productController.selectedCategory.value;

    // Initialize price range from controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final minPrice = productController.minPrice.value;
        final maxPrice = productController.maxPrice.value;
        if (minPrice > 0 || maxPrice > 0) {
          setState(() {
            _priceRange = RangeValues(
              productController.selectedMinPrice.value,
              productController.selectedMaxPrice.value,
            );
          });
        }
      }
    });
  }

  void _applyFilters() {
    if (_priceRange != null) {
      productController.applyFilters(
        category: _selectedCategory,
        minPriceFilter: _priceRange!.start,
        maxPriceFilter: _priceRange!.end,
      );
    } else {
      productController.applyFilters(category: _selectedCategory);
    }
    Get.back();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // green notch
            const SizedBox(height: 10),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Filter By',
              textAlign: TextAlign.center,
              style: AppTypography.titleLargeEmphasized.copyWith(
                color: Get.theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 30),

            // Category filter
            Text(
              'Category',
              style: AppTypography.bodyMediumEmphasized.copyWith(
                color: Get.theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              final categories = ['All', ...categoryController.categoryList.map((c) => c.name)];
              return DropDownField(
                items: categories,
                initialValue: _selectedCategory ?? 'All',
                hintText: 'Select Category',
                onChanged: (value) {
                  setState(() => _selectedCategory = value);
                },
              );
            }),

            const SizedBox(height: 20),

            // Price filter
            Obx(() {
              final minPrice = productController.minPrice.value;
              final maxPrice = productController.maxPrice.value;

              if (minPrice == 0 && maxPrice == 0) {
                return const SizedBox.shrink();
              }

              // Initialize price range if not set
              if (_priceRange == null ||
                  _priceRange!.start < minPrice ||
                  _priceRange!.end > maxPrice) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _priceRange = RangeValues(
                        productController.selectedMinPrice.value > 0
                            ? productController.selectedMinPrice.value
                            : minPrice,
                        productController.selectedMaxPrice.value > 0
                            ? productController.selectedMaxPrice.value
                            : maxPrice,
                      );
                    });
                  }
                });
                // Return a placeholder while initializing
                return const SizedBox.shrink();
              }

              final divisions = ((maxPrice - minPrice) / 10).round().clamp(10, 100);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Price',
                    style: AppTypography.bodyMediumEmphasized.copyWith(
                      color: Get.theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2,
                      overlayShape: SliderComponentShape.noOverlay,
                      trackShape: const RoundedRectSliderTrackShape(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: RangeSlider(
                      values: _priceRange!,
                      onChanged: (value) {
                        setState(() => _priceRange = value);
                      },
                      min: minPrice,
                      max: maxPrice,
                      divisions: divisions,
                      inactiveColor: Get.theme.colorScheme.onSurface.withValues(alpha: 0.4),
                      activeColor: AppColors.primary,
                      labels: RangeLabels(
                        _priceRange!.start.round().toString(),
                        _priceRange!.end.round().toString(),
                      ),
                    ),
                  ),
                  Text(
                    '₹${_priceRange!.start.round()} - ₹${_priceRange!.end.round()}',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyMedium.copyWith(
                      color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              );
            }),

            const Spacer(),

            PrimaryButton(text: 'Apply Filters', onPressed: _applyFilters),
          ],
        ),
      ),
    );
  }
}

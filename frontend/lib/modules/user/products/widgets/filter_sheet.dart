import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/drop_down_field.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:get/get.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  RangeValues _priceRange = const RangeValues(10, 80); // default values
  final _minPrice = 1;
  final _maxPrice = 100;

  void _applyFilters() {
    Toaster.showSuccessMessage(message: 'Filters applied successfully');
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
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 30),

            // Category filter
            Text(
              'Category',
              style: AppTypography.bodyMediumEmphasized.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            const DropDownField(
              items: ['All', 'Vegetable'],
              initialValue: 'All',
              hintText: 'Select Category',
            ),

            const SizedBox(height: 20),

            // Price filter
            Text(
              'Price',
              style: AppTypography.bodyMediumEmphasized.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
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
                values: _priceRange,
                onChanged: (value) {
                  setState(() => _priceRange = value);
                },
                min: _minPrice.toDouble(),
                max: _maxPrice.toDouble(),
                divisions: _maxPrice - _minPrice,
                inactiveColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                activeColor: AppColors.primary,
                labels: RangeLabels(
                  _priceRange.start.round().toString(),
                  _priceRange.end.round().toString(),
                ),
              ),
            ),
            Text(
              '₹${_priceRange.start.round()} - ₹${_priceRange.end.round()}',
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),

            const Spacer(),

            PrimaryButton(text: 'Apply Filters', onPressed: _applyFilters),
          ],
        ),
      ),
    );
  }
}

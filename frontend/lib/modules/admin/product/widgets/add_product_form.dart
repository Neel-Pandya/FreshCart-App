import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/drop_down_field.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/admin/category/controllers/category_controller.dart';
import 'package:get/get.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController,
      _priceController,
      _stockController,
      _descriptionController;
  late final CategoryController _categoryController;
  String? _selectedCategoryName;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _stockController = TextEditingController();
    _descriptionController = TextEditingController();

    // Ensure CategoryController is available and fetch categories
    _categoryController = Get.isRegistered<CategoryController>()
        ? Get.find<CategoryController>()
        : Get.put(CategoryController());
    // Kick off fetch if not already loaded
    if (_categoryController.categoryList.isEmpty) {
      _categoryController.fetchcategoryList();
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleAddProduct() {
    if (!_formKey.currentState!.validate()) return;

    FocusManager.instance.primaryFocus?.unfocus();
    Toaster.showSuccessMessage(message: 'Product added successfully');
    // close the form after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (!mounted) return;
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.border,
              ),
              height: 100,
              width: 100,
              child: const Icon(Icons.camera_alt_outlined, color: AppColors.iconColor, size: 45),
            ),
          ),

          const SizedBox(height: 30),

          FormTextField(
            controller: _nameController,
            prefixIcon: FeatherIcons.briefcase,
            labelText: 'Name',
            filled: false,
            hintText: 'Enter Product Name',
            validator: MultiValidator([
              RequiredValidator(errorText: 'Name is required'),
              MinLengthValidator(3, errorText: 'Name must be at least 3 characters long'),
              MaxLengthValidator(100, errorText: 'Name must be at most 100 characters long'),
              PatternValidator(
                r'^[a-zA-Z0-9 ]+$',
                errorText: 'Name must contain only letters, numbers, and spaces',
              ),
            ]).call,
            keyboardType: TextInputType.name,
          ),

          const SizedBox(height: 15),

          FormTextField(
            controller: _priceController,
            labelText: 'Price',
            filled: false,
            hintText: 'Enter Product Price',
            validator: MultiValidator([
              RequiredValidator(errorText: 'Price is required'),
              MinLengthValidator(1, errorText: 'Price must be at least 1 character long'),
              MaxLengthValidator(100, errorText: 'Price must be at most 100 characters long'),
              PatternValidator(r'^[0-9]+$', errorText: 'Price must contain only numbers'),
            ]).call,

            prefixIcon: Icons.currency_rupee,
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 15),

          Obx(() {
            if (_categoryController.isLoading.value && _categoryController.categoryList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_categoryController.categoryList.isEmpty) {
              return const Center(child: Text('No categories found'));
            }

            final names = _categoryController.categoryList.map((e) => e.name).toList();
            final initial = _selectedCategoryName ?? names.first;

            return DropDownField(
              labelText: 'Category',
              items: names,
              initialValue: initial,
              onChanged: (value) {
                setState(() => _selectedCategoryName = value);
              },
              prefixIcon: Icons.category,
              validator: RequiredValidator(errorText: 'Category is required').call,
            );
          }),

          const SizedBox(height: 15),

          FormTextField(
            controller: _stockController,
            labelText: 'Stock',
            hintText: 'Enter Stock',
            keyboardType: TextInputType.number,
            validator: MultiValidator([
              RequiredValidator(errorText: 'Stock is required'),
              MinLengthValidator(1, errorText: 'Stock must be at least 1 character long'),
              MaxLengthValidator(100, errorText: 'Stock must be at most 100 characters long'),
              PatternValidator(r'^[0-9]+$', errorText: 'Stock must contain only numbers'),
            ]).call,
            prefixIcon: Icons.inventory,
            filled: false,
          ),

          const SizedBox(height: 15),

          FormTextField(
            controller: _descriptionController,
            labelText: 'Description',
            hintText: 'Enter Product Description',
            prefixIcon: FeatherIcons.type,
            validator: RequiredValidator(errorText: 'Description is required').call,
            filled: false,
            maxLines: null,
          ),

          const SizedBox(height: 30),

          PrimaryButton(text: 'Add Product', onPressed: _handleAddProduct),
        ],
      ),
    );
  }
}

import 'dart:typed_data';

import 'package:dio/dio.dart' show FormData, MultipartFile;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/drop_down_field.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/admin/category/controllers/category_controller.dart';
import 'package:frontend/modules/admin/product/controller/product_controller.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

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
  FilePickerResult? _pickedFile;
  Uint8List? _fileBytes;
  final ProductController _productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _stockController = TextEditingController();
    _descriptionController = TextEditingController();

    // Ensure CategoryController is available and fetch categories
    _categoryController = Get.find<CategoryController>();
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

  void _handleAddProduct() async {
    if (!_formKey.currentState!.validate()) return;

    FocusManager.instance.primaryFocus?.unfocus();

    if (_pickedFile == null) {
      Toaster.showErrorMessage(message: 'Please Upload Product Image');
      return;
    }

    final data = FormData.fromMap({
      'image': MultipartFile.fromBytes(_fileBytes!, filename: _pickedFile!.files.first.name),
      'name': _nameController.text.trim(),
      'category': _selectedCategoryName ?? _categoryController.categoryList.first.name,
      'price': _priceController.text.trim(),
      'stock': _stockController.text.trim(),
      'description': _descriptionController.text.trim(),
    });

    final result = await _productController.addProduct(data);
    if (!result) {
      Toaster.showErrorMessage(message: _productController.errorMessage.value);
      return;
    }

    Toaster.showSuccessMessage(message: _productController.responseMessage.value);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      Get.back();
    });
  }

  Future<void> _handleFileUpload() async {
    _pickedFile = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      withData: true,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    setState(() {
      if (_pickedFile!.files.first.size > 1024 * 1024) {
        Toaster.showErrorMessage(message: 'File size should be less than 1MB');
        _pickedFile = null;
        _fileBytes = null;
        return;
      }
      _fileBytes = _pickedFile!.files.first.bytes;
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
            child: GestureDetector(
              onTap: _handleFileUpload,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.border,
                    ),
                    height: 100,
                    width: 100,
                    child: _fileBytes != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.memory(
                              _fileBytes!,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ),
                          )
                        : const Icon(
                            Icons.camera_alt_outlined,
                            color: AppColors.iconColor,
                            size: 45,
                          ),
                  ),
                  if (_fileBytes != null)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _fileBytes = null;
                            _pickedFile = null;
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                ],
              ),
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
                setState(() {
                  _selectedCategoryName = value;
                });
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

          Obx(
            () => PrimaryButton(
              isLoading: _productController.isLoading.value,
              text: 'Add Product',
              onPressed: _categoryController.categoryList.isEmpty ? null : _handleAddProduct,
            ),
          ),
        ],
      ),
    );
  }
}

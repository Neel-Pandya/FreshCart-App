import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/admin/category/controllers/category_controller.dart';
import 'package:frontend/core/models/category.dart';
import 'package:get/get.dart';

class UpdateCategoryForm extends StatefulWidget {
  const UpdateCategoryForm({super.key, required this.category});

  final Category category;

  @override
  State<UpdateCategoryForm> createState() => _UpdateCategoryFormState();
}

class _UpdateCategoryFormState extends State<UpdateCategoryForm> {
  late final TextEditingController _categoryNameController;
  late final CategoryController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = Get.find<CategoryController>();
    _categoryNameController = TextEditingController(text: widget.category.name);
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _handleUpdateCategory() async {
    if (!_formKey.currentState!.validate()) return;

    final result = await _controller.updateCategory(
      widget.category.id,
      _categoryNameController.text,
    );
    if (!result) {
      Toaster.showErrorMessage(message: _controller.error.value);
      return;
    }
    Toaster.showSuccessMessage(message: 'Category updated successfully');

    // close the form after 2 seconds
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
          FormTextField(
            controller: _categoryNameController,
            labelText: 'Category',
            filled: false,
            hintText: 'Enter Category Name',
            validator: MultiValidator([
              RequiredValidator(errorText: 'Category name is required'),
              MinLengthValidator(3, errorText: 'Category name must be at least 3 characters long'),
              MaxLengthValidator(
                100,
                errorText: 'Category name must be at most 100 characters long',
              ),
              PatternValidator(
                r'^[a-zA-Z0-9 ]+$',
                errorText: 'Category name must contain only letters, numbers, and spaces',
              ),
            ]).call,
          ),

          const SizedBox(height: 20),
          Obx(
            () => PrimaryButton(
              text: 'Update Category',
              onPressed: _handleUpdateCategory,
              isLoading: _controller.isLoading.value,
            ),
          ),
        ],
      ),
    );
  }
}

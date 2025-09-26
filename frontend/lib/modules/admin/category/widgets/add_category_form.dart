import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/admin/category/controllers/category_controller.dart';
import 'package:get/get.dart';

class AddCategoryForm extends StatefulWidget {
  const AddCategoryForm({super.key});

  @override
  State<AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  late final TextEditingController _categoryNameController;
  late final CategoryController _categoryController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _categoryNameController = TextEditingController();
    _categoryController = Get.find<CategoryController>();
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _handleAddCategory() async {
    if (!_formKey.currentState!.validate()) return;

    final response = await _categoryController.addCategory(_categoryNameController.text);
    if (!response) {
      Toaster.showErrorMessage(message: _categoryController.error.value);
      return;
    }

    Toaster.showSuccessMessage(message: _categoryController.responseMessage.value);

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
            labelText: 'Category Name',
            prefixIcon: Icons.category,
            filled: false,
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
              text: 'Add Category',
              onPressed: () => _handleAddCategory(),
              isLoading: _categoryController.isLoading.value,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/admin/category/models/category.dart';
import 'package:get/get.dart';

class UpdateCategoryForm extends StatefulWidget {
  const UpdateCategoryForm({super.key, required this.category});

  final Category category;

  @override
  State<UpdateCategoryForm> createState() => _UpdateCategoryFormState();
}

class _UpdateCategoryFormState extends State<UpdateCategoryForm> {
  late final TextEditingController _categoryNameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _categoryNameController = TextEditingController(text: widget.category.name);
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _handleUpdateCategory() {
    if (!_formKey.currentState!.validate()) return;

    Toaster.showSuccessMessage(context: context, message: 'Category updated successfully');

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
          PrimaryButton(text: 'Update Category', onPressed: _handleUpdateCategory),
        ],
      ),
    );
  }
}

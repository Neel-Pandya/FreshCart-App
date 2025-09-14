import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/drop_down_field.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/features/admin/products/models/product.dart';

class UpdateProductForm extends StatefulWidget {
  const UpdateProductForm({super.key, required this.product});

  final Product product;

  @override
  State<UpdateProductForm> createState() => _UpdateProductFormState();
}

class _UpdateProductFormState extends State<UpdateProductForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController,
      _priceController,
      _stockController,
      _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _priceController = TextEditingController(text: widget.product.price.toStringAsFixed(0));
    _stockController = TextEditingController(text: widget.product.quantity.toString());
    _descriptionController = TextEditingController(text: widget.product.description);
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

  void _handleUpdateProduct() {
    if (!_formKey.currentState!.validate()) return;

    FocusManager.instance.primaryFocus?.unfocus();
    Toaster.showSuccessMessage(context: context, message: 'Product updated successfully');
    // close the form after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (!mounted) return;
      Navigator.of(context).pop();
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
              child: widget.product.imageUrl != ''
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(widget.product.imageUrl, fit: BoxFit.cover),
                    )
                  : const Icon(Icons.camera_alt_outlined, color: AppColors.iconColor, size: 45),
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

          DropDownField(
            labelText: 'Category',
            items: ['Vegetable', 'Fruit'],
            initialValue: widget.product.category,
            onChanged: (value) {},
            prefixIcon: Icons.category,
            validator: RequiredValidator(errorText: 'Category is required').call,
          ),

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

          PrimaryButton(text: 'Update Product', onPressed: _handleUpdateProduct),
        ],
      ),
    );
  }
}

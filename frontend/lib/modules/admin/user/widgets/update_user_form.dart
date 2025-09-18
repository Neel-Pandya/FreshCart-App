import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/admin/user/models/user.dart';
import 'package:get/get.dart';

class UpdateUserForm extends StatefulWidget {
  const UpdateUserForm({super.key, required this.user});
  final User user;

  @override
  State<UpdateUserForm> createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController, _emailController;

  void _handleUpdateUser() {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    Toaster.showSuccessMessage(message: 'User updated successfully');
    // close the form after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Get.back();
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    widget.user.imageUrl,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.textPrimary.withValues(alpha: 0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(FeatherIcons.edit2, size: 16, color: AppColors.textPrimary),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          FormTextField(
            labelText: 'Name',
            filled: false,
            controller: _nameController,
            hintText: 'Enter User Name',
            validator: MultiValidator([
              RequiredValidator(errorText: 'Name is required'),
              MinLengthValidator(3, errorText: 'Name must be at least 3 characters long'),
              MaxLengthValidator(100, errorText: 'Name must be at most 100 characters long'),
              PatternValidator(
                r'^[a-zA-Z0-9 ]+$',
                errorText: 'Name must contain only letters, numbers, and spaces',
              ),
            ]).call,
            prefixIcon: FeatherIcons.user,
          ),

          const SizedBox(height: 15),

          FormTextField(
            labelText: 'Email',
            filled: false,
            readonly: true,
            controller: _emailController,
            hintText: 'Enter User Email',
            validator: MultiValidator([
              RequiredValidator(errorText: 'Email is required'),
              EmailValidator(errorText: 'Invalid email address'),
            ]).call,
            prefixIcon: FeatherIcons.mail,
          ),

          const SizedBox(height: 15),

          PrimaryButton(text: 'Update User', onPressed: _handleUpdateUser),
        ],
      ),
    );
  }
}

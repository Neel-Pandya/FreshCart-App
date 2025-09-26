import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:get/get.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({super.key});

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  late final TextEditingController _nameController, _emailController, _passwordController;

  void _handleAddUser() {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    Toaster.showSuccessMessage(message: 'User added successfully');
    // close the form after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Get.back();
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
            controller: _emailController,
            hintText: 'Enter User Email',
            validator: MultiValidator([
              RequiredValidator(errorText: 'Email is required'),
              EmailValidator(errorText: 'Invalid email address'),
            ]).call,
            prefixIcon: FeatherIcons.mail,
          ),

          const SizedBox(height: 15),

          FormTextField(
            labelText: 'Password',
            filled: false,
            suffixIcon: _isPasswordVisible ? FeatherIcons.eye : FeatherIcons.eyeOff,
            onSuffixTap: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            hintText: 'Enter User Password',
            validator: MultiValidator([
              RequiredValidator(errorText: 'Password is required'),
              MinLengthValidator(6, errorText: 'Password must be at least 6 characters long'),
              MaxLengthValidator(100, errorText: 'Password must be at most 100 characters long'),
              PatternValidator(
                r'^(?=.*[A-Z]).+$',
                errorText: 'Must contain at least one uppercase letter',
              ),

              PatternValidator(
                r'^(?=.*[a-z]).+$',
                errorText: 'Must contain at least one lowercase letter',
              ),

              PatternValidator(r'^(?=.*\d).+$', errorText: 'Must contain at least one number'),

              PatternValidator(
                r'^(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]).+$',
                errorText: 'Must contain at least one special character',
              ),
            ]).call,
            prefixIcon: FeatherIcons.lock,
          ),

          const SizedBox(height: 20),

          PrimaryButton(text: 'Add User', onPressed: _handleAddUser),
        ],
      ),
    );
  }
}

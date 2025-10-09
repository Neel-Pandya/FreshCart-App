import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/modules/admin/user/controller/user_controller.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:dio/dio.dart' show FormData, MultipartFile;
import 'package:file_picker/file_picker.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({super.key});

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final _formKey = GlobalKey<FormState>();
  final _userController = Get.find<UserController>();
  bool _isPasswordVisible = false;
  FilePickerResult? _pickedFile;
  Uint8List? _fileBytes;
  bool _isLoading = false;

  late final TextEditingController _nameController, _emailController, _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future<void> _pickImage() async {
    try {
      _pickedFile = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        withData: true,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );

      setState(() {
        if (_pickedFile != null && _pickedFile!.files.first.size > 1024 * 1024) {
          Toaster.showErrorMessage(message: 'File must be less than 1 MB');
          _pickedFile = null;
          _fileBytes = null;
          return;
        }
        _fileBytes = _pickedFile?.files.first.bytes;
      });
    } catch (e) {
      Toaster.showErrorMessage(message: 'Failed to pick image: $e');
    }
  }

  Future<void> _handleAddUser() async {
    if (!_formKey.currentState!.validate()) return;

    // Validate that image is selected
    if (_fileBytes == null) {
      Toaster.showErrorMessage(message: 'User image is required');
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _isLoading = true;
    });

    final formData = FormData.fromMap({
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text,
      'role': 0, // Default role for regular users
      'status': 'active',
    });

    formData.files.add(
      MapEntry(
        'profile',
        MultipartFile.fromBytes(_fileBytes!, filename: _pickedFile!.files.first.name),
      ),
    );

    final success = await _userController.addUser(formData);

    if (success) {
      Toaster.showSuccessMessage(message: _userController.responseMessage.value);
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        Get.back();
      });
    }

    setState(() {
      _isLoading = false;
    });
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
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
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
                    : const Icon(Icons.camera_alt_outlined, color: AppColors.iconColor, size: 45),
              ),
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

          PrimaryButton(
            text: 'Add User',
            onPressed: _isLoading ? null : _handleAddUser,
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }
}

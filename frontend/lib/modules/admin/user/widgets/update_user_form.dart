import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/admin/user/models/user.dart';
import 'package:frontend/modules/admin/user/controller/user_controller.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:dio/dio.dart' show FormData, MultipartFile;
import 'package:file_picker/file_picker.dart';

class UpdateUserForm extends StatefulWidget {
  const UpdateUserForm({super.key, required this.user});
  final User user;

  @override
  State<UpdateUserForm> createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  final _formKey = GlobalKey<FormState>();
  final _userController = Get.find<UserController>();
  FilePickerResult? _pickedFile;
  Uint8List? _fileBytes;

  late final TextEditingController _nameController, _emailController;

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

  Future<void> _handleUpdateUser() async {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    final formData = FormData.fromMap({
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      if (_fileBytes != null)
        'profile': MultipartFile.fromBytes(_fileBytes!, filename: _pickedFile!.files.first.name),
    });

    final success = await _userController.updateUser(widget.user.userId, formData);

    if (success) {
      Toaster.showSuccessMessage(message: _userController.responseMessage.value);
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        Get.back();
      });
    } else {
      Toaster.showErrorMessage(message: _userController.errorMessage.value);
    }
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
                  child: _fileBytes != null
                      ? Image.memory(_fileBytes!, height: 80, width: 80, fit: BoxFit.cover)
                      : widget.user.imageUrl.isNotEmpty
                      ? Image.network(
                          widget.user.imageUrl,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Get.theme.colorScheme.surface,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: Get.theme.colorScheme.onSurface,
                              ),
                            );
                          },
                        )
                      : Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.surface,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Get.theme.colorScheme.onSurface,
                          ),
                        ),
                ),

                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: _pickImage,
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        FeatherIcons.edit2,
                        size: 16,
                        color: Get.theme.colorScheme.onSurface,
                      ),
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

          Obx(
            () => PrimaryButton(
              text: 'Update User',
              isLoading: _userController.isLoading.value,
              onPressed: _handleUpdateUser,
            ),
          ),
        ],
      ),
    );
  }
}

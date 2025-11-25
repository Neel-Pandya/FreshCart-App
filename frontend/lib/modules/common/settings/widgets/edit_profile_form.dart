import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/common/auth/common/controllers/auth_controller.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:dio/dio.dart' show FormData, MultipartFile;

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  final AuthController _authController = Get.find<AuthController>();
  Uint8List? _fileBytes;
  var _fileName = '';

  void _updateProfile(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    final data = FormData.fromMap({
      'name': _nameController.text.trim(),
      if (_fileBytes != null) 'profile': MultipartFile.fromBytes(_fileBytes!, filename: _fileName),
    });
    final result = await _authController.updateProfile(data);

    if (!result) {
      Toaster.showErrorMessage(message: _authController.error.value);
      return;
    }

    Toaster.showSuccessMessage(message: _authController.responseMessage.value);
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _authController.user.value?.name);
    _emailController = TextEditingController(text: _authController.user.value?.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> _handleImagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      allowMultiple: false,
      withData: true,
    );

    if (result == null) return;

    setState(() {
      _fileBytes = result.files.first.bytes;
      _fileName = result.files.first.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: _fileBytes != null
                    ? Image.memory(_fileBytes!, height: 80, width: 80, fit: BoxFit.cover)
                    : Image.network(
                        _authController.user.value!.imageUrl,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 80,
                            width: 80,
                            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.1),
                            child: Icon(
                              FeatherIcons.user,
                              color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.3),
                            ),
                          );
                        },
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: _handleImagePicker,
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
          const SizedBox(height: 30),
          FormTextField(
            prefixIcon: FeatherIcons.user,
            controller: _nameController,
            labelText: 'Name',
            hintText: 'Enter Name',
            validator: MultiValidator([
              RequiredValidator(errorText: 'Name is required'),
              MinLengthValidator(2, errorText: 'At least 2 characters'),
              MaxLengthValidator(50, errorText: 'At most 50 characters'),
              PatternValidator(
                r'^[a-zA-Z\s]+$',
                errorText: 'Name can only contain letters and spaces',
              ),
            ]).call,
          ),
          const SizedBox(height: 20),
          FormTextField(
            prefixIcon: FeatherIcons.mail,
            controller: _emailController,
            readonly: true,
            labelText: 'Email',
            hintText: 'Enter Email',
            validator: MultiValidator([
              RequiredValidator(errorText: 'Email is required'),
              EmailValidator(errorText: 'Invalid email'),
            ]).call,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => PrimaryButton(
                text: 'Save Changes',
                onPressed: () => _updateProfile(context),
                isLoading: _authController.isLoading.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

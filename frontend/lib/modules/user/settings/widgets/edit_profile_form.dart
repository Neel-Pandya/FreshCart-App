import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/common/auth/common/controllers/auth_controller.dart';
import 'package:get/get.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.email,
  });
  final String imageUrl;
  final String name;
  final String email;

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final AuthController controller;
  void _updateProfile(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    FocusManager.instance.primaryFocus?.unfocus();

    Toaster.showSuccessMessage(message: 'Profile updated successfully');
  }

  @override
  void initState() {
    super.initState();
    controller = Get.find<AuthController>();
    _nameController = TextEditingController(text: controller.user.value?.name);
    _emailController = TextEditingController(text: controller.user.value?.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
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
                child: Image.asset(widget.imageUrl, height: 80, width: 80, fit: BoxFit.cover),
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
                      color: Theme.of(context).colorScheme.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      FeatherIcons.edit2,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurface,
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
            child: PrimaryButton(text: 'Save Changes', onPressed: () => _updateProfile(context)),
          ),
        ],
      ),
    );
  }
}

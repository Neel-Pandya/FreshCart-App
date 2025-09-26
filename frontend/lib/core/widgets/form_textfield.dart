import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:get/get.dart';

class FormTextField extends StatefulWidget {
  const FormTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.validator,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscureText = false,
    this.keyboardType,
    this.readonly = false,
    this.filled = true,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool? readonly;
  final bool? filled;
  final int? maxLines;

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()
      ..addListener(() {
        setState(() => _isFocused = _focusNode.hasFocus);
      });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Color _getIconColor({required Color defaultColor}) {
    if (_hasError) return Get.theme.colorScheme.error;
    if (_isFocused) return AppColors.primary;
    return defaultColor;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType ?? TextInputType.multiline,
      readOnly: widget.readonly ?? false,
      minLines: 1,
      maxLines: widget.maxLines, // <-- multiline support
      validator: (value) {
        final error = widget.validator?.call(value);
        setState(() => _hasError = error != null);
        return error;
      },
      onChanged: widget.onChanged,
      focusNode: _focusNode,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: AppTypography.bodyMedium,
        hintText: widget.hintText,
        hintStyle: AppTypography.bodyMedium,
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: _getIconColor(
                  defaultColor: Get.theme.brightness == Brightness.light
                      ? AppColors.iconColor
                      : Get.theme.colorScheme.onSurface,
                ),
              )
            : null,
        suffixIcon: widget.suffixIcon != null
            ? GestureDetector(
                onTap: widget.onSuffixTap,
                child: Icon(
                  widget.suffixIcon,
                  color: _getIconColor(
                    defaultColor: Get.theme.brightness == Brightness.light
                        ? AppColors.iconColor
                        : Get.theme.colorScheme.onSurface,
                  ),
                ),
              )
            : null,
        filled: widget.filled ?? true,
        fillColor: _isFocused
            ? Get.theme.colorScheme.surface
            : Get.theme.brightness == Brightness.light
            ? const Color(0xFFE0E0E0).withAlpha(35)
            : Get.theme.colorScheme.onSurface.withValues(alpha: 0.05),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.light
                ? const Color.fromRGBO(224, 224, 224, 1)
                : AppColors.borderDark,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Get.theme.colorScheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Get.theme.colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Get.theme.colorScheme.error, width: 1.5),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_colors.dart';

class DropDownField extends StatefulWidget {
  const DropDownField({
    super.key,
    required this.items,
    required this.initialValue,
    this.onChanged,
    this.hintText,
    this.validator,
    this.prefixIcon,
    this.labelText,
  });

  final List<String> items;
  final void Function(String?)? onChanged;
  final String initialValue;
  final String? hintText;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final String? labelText;

  @override
  State<DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
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

  Color _getIconColor() {
    if (_hasError) return AppColors.error;
    if (_isFocused) return AppColors.primary;
    return AppColors.iconColor;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      focusNode: _focusNode,
      initialValue: widget.initialValue,
      icon: Padding(
        padding: const EdgeInsetsDirectional.only(end: 10),
        child: Icon(FeatherIcons.chevronDown, color: _getIconColor()),
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: _getIconColor())
            : null,
        fillColor: _isFocused ? AppColors.background : Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFCAC4D0), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      ),
      items: widget.items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: widget.onChanged ?? (value) {},
      hint: widget.hintText != null ? Text(widget.hintText!) : null,
      validator: (value) {
        final error = widget.validator?.call(value);
        setState(() => _hasError = error != null);
        return error;
      },
    );
  }
}

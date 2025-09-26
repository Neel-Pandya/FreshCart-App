import 'package:form_field_validator/form_field_validator.dart';

class ConfirmPasswordValidator extends FieldValidator<String> {
  final String Function() getPassword;
  ConfirmPasswordValidator({required this.getPassword, String errorText = 'Passwords do not match'})
    : super(errorText);

  @override
  bool isValid(dynamic value) {
    return value == getPassword();
  }
}

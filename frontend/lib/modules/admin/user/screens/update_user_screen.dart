import 'package:flutter/material.dart';
import 'package:frontend/modules/admin/user/models/user.dart';
import 'package:frontend/modules/admin/user/widgets/update_user_form.dart';

class UpdateUserScreen extends StatelessWidget {
  const UpdateUserScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update User')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: UpdateUserForm(user: user),
          ),
        ),
      ),
    );
  }
}

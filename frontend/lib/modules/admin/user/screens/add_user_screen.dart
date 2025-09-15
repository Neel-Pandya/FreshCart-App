import 'package:flutter/material.dart';
import 'package:frontend/modules/admin/user/widgets/add_user_form.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add User')),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: AddUserForm(),
          ),
        ),
      ),
    );
  }
}

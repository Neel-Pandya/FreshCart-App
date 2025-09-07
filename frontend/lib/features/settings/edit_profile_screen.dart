import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/features/settings/widgets/edit_profile_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: AppTypography.titleLarge.copyWith(color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(height: 1, thickness: 1, color: AppColors.border),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: EditProfileForm(
                imageUrl: 'assets/images/user/common_profile.png',
                name: 'Neel Pandya',
                email: 'neelpandya2601@gmail.com',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

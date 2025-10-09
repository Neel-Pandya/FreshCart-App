import 'package:flutter/material.dart';
import 'package:frontend/core/routes/admin_routes.dart';
import 'package:frontend/modules/admin/user/controller/user_controller.dart';
import 'package:frontend/modules/admin/user/widgets/user_list_item.dart';
import 'package:get/get.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AdminRoutes.addUser);
        },
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          if (userController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userController.users.isEmpty) {
            return const Center(child: Text('No users found', style: TextStyle(fontSize: 16)));
          }

          return ListView.separated(
            itemCount: userController.users.length,
            itemBuilder: (context, index) => UserListItem(user: userController.users[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          );
        }),
      ),
    );
  }
}

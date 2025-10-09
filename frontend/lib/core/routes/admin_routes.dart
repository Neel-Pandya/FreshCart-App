import 'package:get/get.dart';
import 'package:frontend/modules/admin/category/screens/add_category_screen.dart';
import 'package:frontend/modules/admin/product/screens/add_product_screen.dart';
import 'package:frontend/modules/admin/user/screens/add_user_screen.dart';
import 'package:frontend/modules/admin/user/screens/update_user_screen.dart';
import 'package:frontend/layout/admin_master_layout.dart';

class AdminRoutes {
  AdminRoutes._();

  static const master = '/admin/master';
  static const addProduct = '/admin/addProduct';
  static const addCategory = '/admin/addCategory';
  static const addUser = '/admin/addUser';
  static const updateUser = '/admin/updateUser';

  static final routes = [
    GetPage(name: master, page: () => const AdminMasterLayout()),
    GetPage(name: addProduct, page: () => const AddProductScreen()),
    GetPage(name: addCategory, page: () => const AddCategoryScreen()),
    GetPage(name: addUser, page: () => const AddUserScreen()),
    GetPage(
      name: updateUser,
      page: () => UpdateUserScreen(user: Get.arguments),
    ),
  ];
}

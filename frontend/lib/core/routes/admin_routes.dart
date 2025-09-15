import 'package:flutter/material.dart';
import 'package:frontend/modules/admin/category/screens/add_category_screen.dart';
import 'package:frontend/modules/admin/product/screens/add_product_screen.dart';
import 'package:frontend/modules/admin/user/screens/add_user_screen.dart';
import 'package:frontend/layout/admin_master_layout.dart';

class AdminRoutes {
  AdminRoutes._();

  static const master = '/admin/master';
  static const addProduct = '/admin/addProduct';
  static const addCategory = '/admin/addCategory';
  static const addUser = '/admin/addUser';
  static Map<String, WidgetBuilder> routes = {
    master: (context) => const AdminMasterLayout(),
    addProduct: (context) => const AddProductScreen(),
    addCategory: (context) => const AddCategoryScreen(),
    addUser: (context) => const AddUserScreen(),
  };
}

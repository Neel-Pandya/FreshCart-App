import 'package:flutter/material.dart';
import 'package:frontend/modules/admin/category/screens/add_category_screen.dart';
import 'package:frontend/modules/admin/product/screens/add_product_screen.dart';
import 'package:frontend/layout/admin_master_layout.dart';

class AdminRoutes {
  AdminRoutes._();

  static const master = '/admin/master';
  static const addProduct = '/admin/addProduct';
  static const addCategory = '/admin/addCategory';
  static Map<String, WidgetBuilder> routes = {
    master: (context) => const AdminMasterLayout(),
    addProduct: (context) => const AddProductScreen(),
    addCategory: (context) => const AddCategoryScreen(),
  };
}

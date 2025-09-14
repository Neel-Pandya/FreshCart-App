import 'package:flutter/material.dart';
import 'package:frontend/features/admin/products/screens/add_product_screen.dart';
import 'package:frontend/features/admin/products/screens/update_product_screen.dart';
import 'package:frontend/layout/admin_master_layout.dart';

class AdminRoutes {
  AdminRoutes._();

  static const master = '/admin/master';
  static const addProduct = '/admin/addProduct';
  static Map<String, WidgetBuilder> routes = {
    master: (context) => const AdminMasterLayout(),
    addProduct: (context) => const AddProductScreen(),
  };
}

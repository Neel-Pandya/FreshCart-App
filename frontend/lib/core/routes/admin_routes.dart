import 'package:flutter/material.dart';
import 'package:frontend/layout/admin_master_layout.dart';

class AdminRoutes {
  AdminRoutes._();

  static const master = '/admin/master';

  static Map<String, WidgetBuilder> routes = {master: (context) => const AdminMasterLayout()};
}

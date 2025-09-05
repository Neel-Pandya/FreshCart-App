import 'package:flutter/material.dart';
import 'package:frontend/layout/user_master_layout.dart';

class UserRoutes {
  UserRoutes._();

  static const master = '/master';

  static final routes = <String, WidgetBuilder>{master: (_) => UserMasterLayout()};
}

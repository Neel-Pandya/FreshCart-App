import 'package:flutter/material.dart';
import 'package:frontend/features/cart/cart_screen.dart';
import 'package:frontend/features/checkout/checkout_screen.dart';
import 'package:frontend/features/settings/edit_profile_screen.dart';
import 'package:frontend/layout/user_master_layout.dart';
import 'package:frontend/features/settings/change_password_screen.dart';

class UserRoutes {
  UserRoutes._();

  static const master = '/master';
  static const changePassword = '/changePassword';
  static const editProfile = '/editProfile';
  static const cart = '/cart';
  static const checkout = '/checkout';

  static final routes = <String, WidgetBuilder>{
    master: (_) => const UserMasterLayout(),
    changePassword: (_) => const ChangePasswordScreen(),
    editProfile: (_) => const EditProfileScreen(),
    cart: (_) => const CartScreen(),
    checkout: (_) => const CheckoutScreen(),
  };
}

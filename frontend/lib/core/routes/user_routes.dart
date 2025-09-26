import 'package:get/get.dart';
import 'package:frontend/modules/user/cart/screens/cart_screen.dart';
import 'package:frontend/modules/user/checkout/screens/checkout_screen.dart';
import 'package:frontend/modules/common/settings/screens/change_password_screen.dart';
import 'package:frontend/modules/common/settings/screens/edit_profile_screen.dart';
import 'package:frontend/layout/user_master_layout.dart';

class UserRoutes {
  UserRoutes._();

  static const master = '/master';
  static const changePassword = '/changePassword';
  static const editProfile = '/editProfile';
  static const cart = '/cart';
  static const checkout = '/checkout';

  static final routes = [
    GetPage(
      name: master,
      page: () => const UserMasterLayout(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: changePassword,
      page: () => const ChangePasswordScreen(),
      transition: Transition.native,
    ),
    GetPage(
      name: editProfile,
      page: () => const EditProfileScreen(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(name: cart, page: () => const CartScreen(), transition: Transition.native),
    GetPage(name: checkout, page: () => CheckoutScreen(), transition: Transition.native),
  ];
}

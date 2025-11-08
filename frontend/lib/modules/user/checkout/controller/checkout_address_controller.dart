import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutAddressController extends GetxController {
  final addressController = TextEditingController();

  @override
  void onClose() {
    addressController.dispose();
    super.onClose();
  }

  String getDeliveryAddress() {
    return addressController.text;
  }
}

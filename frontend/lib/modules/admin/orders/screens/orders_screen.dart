import 'package:flutter/widgets.dart';
import 'package:frontend/modules/admin/orders/data/order_data.dart';
import 'package:frontend/modules/admin/orders/widgets/order_list_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: orderData.length,
          itemBuilder: (context, index) => OrderListItem(
            order: orderData[index],
            imageUrl: 'assets/images/user/common_profile.png',
          ),
        ),
      ),
    );
  }
}

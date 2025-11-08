import 'package:frontend/core/models/admin_order.dart';
import 'package:frontend/core/models/order.dart' as common;

// This file is deprecated - using real data from AdminOrderController now
// Keeping for reference only
final orderData = <AdminOrder>[
  AdminOrder(
    id: '2321',
    userId: '1',
    userName: 'Neel Pandya',
    userEmail: 'neel@example.com',
    userProfile: '',
    items: [
      const common.OrderItem(
        productId: '1',
        productName: 'Apple',
        price: 200,
        quantity: 5,
        total: 1000,
        imageUrl:
            'https://plus.unsplash.com/premium_photo-1724249989963-9286e126af81?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGFwcGxlfGVufDB8fDB8fHww',
      ),
      const common.OrderItem(
        productId: '2',
        productName: 'Carrot',
        price: 100,
        quantity: 10,
        total: 1000,
        imageUrl:
            'https://images.unsplash.com/photo-1576181256399-834e3b3a49bf?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGNhcnJvdHxlbnwwfHwwfHx8MA%3D%3D',
      ),
    ],
    totalAmount: 2000,
    paymentMethod: 'Cash on Delivery',
    deliveryAddress: 'Sample Address',
    createdAt: DateTime.now(),
  ),
];

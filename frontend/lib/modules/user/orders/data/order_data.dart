import 'package:frontend/core/models/order.dart';

final orderData = const <Order>[
  Order(
    id: '1',
    userId: '2',
    status: 'complete',
    productAmount: 300.00,
    productName: 'Apple',
    productImage:
        'https://images.unsplash.com/photo-1607305387299-a3d9611cd469?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8dG9tYXRvfGVufDB8fDB8fHww',
    quantity: 1,
  ),

  Order(
    id: '2',
    userId: '3',
    status: 'complete',
    productAmount: 20,
    productName: 'Apple',
    productImage:
        'https://images.unsplash.com/photo-1607305387299-a3d9611cd469?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8dG9tYXRvfGVufDB8fDB8fHww',
    quantity: 1,
  ),
];

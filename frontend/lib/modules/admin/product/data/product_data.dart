import 'package:frontend/core/models/admin_product.dart';

final productsData = <Product>[
  Product(
    productId: '1',
    name: 'Apple',
    imageUrl:
        'https://plus.unsplash.com/premium_photo-1724249989963-9286e126af81?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGFwcGxlfGVufDB8fDB8fHww',
    description:
        'Apples are a popular fruit known for their nutritional benefits. They are rich in fiber, vitamins, and antioxidants, making them a healthy addition to any diet.',
    price: 15,
    quantity: 3,
    category: 'Fruit',
  ),
  Product(
    productId: '2',
    name: 'Carrot',
    imageUrl:
        'https://images.unsplash.com/photo-1576181256399-834e3b3a49bf?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGNhcnJvdHxlbnwwfHwwfHx8MA%3D%3D',
    description:
        'Carrots are a root vegetable known for their nutritional benefits. They are rich in vitamins, minerals, and antioxidants, making them a healthy addition to any diet.',
    price: 10,
    quantity: 3,
    category: 'Vegetable',
  ),
  Product(
    productId: '3',
    name: 'Tomato',
    imageUrl:
        'https://images.unsplash.com/photo-1607305387299-a3d9611cd469?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8dG9tYXRvfGVufDB8fDB8fHww',
    description:
        'Tomatoes are a popular fruit known for their nutritional benefits. They are rich in fiber, vitamins, and antioxidants, making them a healthy addition to any diet.',
    price: 12,
    quantity: 3,
    category: 'Vegetable',
  ),
];

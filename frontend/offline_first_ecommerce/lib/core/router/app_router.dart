import 'package:go_router/go_router.dart';
import 'package:offline_first_ecommerce/features/cart/presentation/pages/cart_page.dart';
import 'package:offline_first_ecommerce/features/product/presentation/pages/product_page.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductPage(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartPage(),
    ),
  ],
);
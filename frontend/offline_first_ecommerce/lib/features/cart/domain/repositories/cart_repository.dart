import 'package:dartz/dartz.dart';
import 'package:offline_first_ecommerce/features/cart/domain/entities/cart_item.dart';


abstract class CartRepository {
  Future<Either<String, List<CartItem>>> getCartItems();
  Future<void> addToCart(CartItem item);
  Future<void> removeFromCart(String productId);
  Future<void> clearCart();

}
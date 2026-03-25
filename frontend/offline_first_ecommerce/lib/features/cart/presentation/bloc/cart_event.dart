
// --- Events ---
import 'package:offline_first_ecommerce/features/cart/domain/entities/cart_item.dart';

abstract class CartEvent {}
class LoadCart extends CartEvent {}
class AddToCart extends CartEvent { final CartItem item; AddToCart(this.item); }
class RemoveFromCart extends CartEvent { final String productId; RemoveFromCart(this.productId); }

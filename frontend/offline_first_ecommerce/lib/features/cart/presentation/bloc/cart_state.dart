
// --- States ---
import 'package:offline_first_ecommerce/features/cart/domain/entities/cart_item.dart';

abstract class CartState {}
class CartLoading extends CartState {}
class CartLoaded extends CartState { 
  final List<CartItem> items; 
  final double totalAmount;
  CartLoaded(this.items, this.totalAmount); 
}
class CartError extends CartState { final String message; CartError(this.message); }

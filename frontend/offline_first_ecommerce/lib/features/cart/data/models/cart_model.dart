import 'package:isar/isar.dart';
import '../../domain/entities/cart_item.dart';

part 'cart_model.g.dart';

@collection
class CartItemModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String? productId;
  
  String? name;
  double? price;
  String? image;
  int quantity = 1;

  // Model to Entity
  CartItem toEntity() {
    return CartItem(
      productId: productId ?? '',
      name: name ?? '',
      price: price ?? 0.0,
      image: image ?? '',
      quantity: quantity,
    );
  }

  // Entity to Model (Database mein save karne ke liye)
  static CartItemModel fromEntity(CartItem entity) {
    return CartItemModel()
      ..productId = entity.productId
      ..name = entity.name
      ..price = entity.price
      ..image = entity.image
      ..quantity = entity.quantity;
  }
}
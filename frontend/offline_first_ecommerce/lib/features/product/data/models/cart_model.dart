import 'package:isar/isar.dart';

part 'cart_model.g.dart';

@collection
class CartItem {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  int? productId;
  
  String? name;
  double? price;
  String? image;
  int quantity = 1;

  double get totalPrice => (price ?? 0) * quantity;
}
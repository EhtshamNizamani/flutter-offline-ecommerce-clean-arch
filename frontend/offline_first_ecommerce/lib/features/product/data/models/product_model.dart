import 'package:isar/isar.dart';
import '../../domain/entities/product.dart';

part 'product_model.g.dart';

@collection
class ProductModel {

  ProductModel(); // 👈 Required constructor

  Id? isarId;

  @Index(unique: true, replace: true)
  late String id;
  late String name;
  late String description;
  late double price;
  late String category;
  late String image;
  late int stock;

  static ProductModel fromEntity(Product product) {
    return ProductModel()
      ..id = product.id
      ..name = product.name
      ..description = product.description
      ..price = product.price
      ..category = product.category
      ..image = product.image
      ..stock = product.stock;
  }

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      category: category,
      image: image,
      stock: stock,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel()
      ..id = json['_id'] ?? ''
      ..name = json['name'] ?? ''
      ..description = json['description'] ?? ''
      ..price = (json['price'] as num).toDouble()
      ..category = json['category'] ?? ''
      ..image = json['image'] ?? ''
      ..stock = json['stock'] ?? 0;
  }
}
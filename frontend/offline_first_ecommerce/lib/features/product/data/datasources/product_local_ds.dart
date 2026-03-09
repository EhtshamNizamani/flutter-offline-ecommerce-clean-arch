import 'package:isar/isar.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Isar isar;
  ProductLocalDataSourceImpl(this.isar);

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    await isar.writeTxn(() async {
      await isar.productModels.putAll(products); // Purane update/replace ho jayenge
    });
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    return await isar.productModels.where().findAll();
  }
}
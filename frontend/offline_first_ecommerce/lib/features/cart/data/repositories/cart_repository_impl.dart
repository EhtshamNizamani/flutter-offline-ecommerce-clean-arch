import 'package:isar/isar.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final Isar isar;
  CartRepositoryImpl(this.isar);

  @override
  Future<void> addToCart(CartItem item) async {
    await isar.writeTxn(() async {
      final existing = await isar.cartItemModels
          .filter()
          .productIdEqualTo(item.productId)
          .findFirst();

      if (existing != null) {
        existing.quantity += 1;
        await isar.cartItemModels.put(existing);
      } else {
        await isar.cartItemModels.put(CartItemModel.fromEntity(item));
      }
    });
  }

  @override
  Future<Either<String, List<CartItem>>> getCartItems() async {
    try {
      final models = await isar.cartItemModels.where().findAll();
      final entities = models.map((m) => m.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left("Could not fetch cart items");
    }
  }

  @override
  Future<void> removeFromCart(String productId) async {
    await isar.writeTxn(() async {
      await isar.cartItemModels
          .filter()
          .productIdEqualTo(productId)
          .deleteFirst();
    });
  }

  @override
  Future<void> clearCart() async {
    await isar.writeTxn(() => isar.cartItemModels.clear());
  }
}

import '../repositories/product_repository.dart';

class GetProductUseCase {
  final ProductRepository repository;
  GetProductUseCase(this.repository);
}
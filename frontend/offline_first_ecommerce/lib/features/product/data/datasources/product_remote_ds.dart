import '../../../../core/api/api_service.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiService apiService;
  ProductRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await apiService.get('/products');
    final List data = response.data['products'];
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }
}
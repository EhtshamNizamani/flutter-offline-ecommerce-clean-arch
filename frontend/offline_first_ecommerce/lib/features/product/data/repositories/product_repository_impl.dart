import 'package:dartz/dartz.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_ds.dart';
import '../datasources/product_remote_ds.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDS;
  final ProductLocalDataSource localDS;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDS,
    required this.localDS,
    required this.networkInfo,
  });

  @override
  Future<Either<String, List<Product>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDS.getProducts();
        await localDS.cacheProducts(remoteProducts); // Offline ke liye save kar lo
        return Right(remoteProducts.map((m) => m.toEntity()).toList());
      } catch (e) {
        return const Left("Server Failure");
      }
    } else {
      try {
        final localProducts = await localDS.getCachedProducts();
        if (localProducts.isNotEmpty) {
          return Right(localProducts.map((m) => m.toEntity()).toList());
        }
        return const Left("No Internet and No Cached Data");
      } catch (e) {
        return const Left("Local DB Failure");
      }
    }
  }

  
}
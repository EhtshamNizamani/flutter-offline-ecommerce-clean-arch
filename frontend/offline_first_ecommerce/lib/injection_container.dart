import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:offline_first_ecommerce/core/service/token_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'core/api/api_service.dart';
import 'core/network/network_info.dart';
import 'features/product/data/datasources/product_local_ds.dart';
import 'features/product/data/datasources/product_remote_ds.dart';
import 'features/product/data/models/product_model.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 1. External & Core
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [ProductModelSchema], // Generated from .g.dart
    directory: dir.path,
  );
  sl.registerSingleton<Isar>(isar);

  sl.registerLazySingleton(() => TokenService());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => ApiService(sl(), sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));

  // 2. Features - Product
  // Data Sources
  sl.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ProductLocalDataSource>(() => ProductLocalDataSourceImpl(sl()));
  
  // Repository
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
    remoteDS: sl(),
    localDS: sl(),
    networkInfo: sl(),
  ));

  // Bloc (Factory use karein taake har dafa naya instance mile)
  sl.registerFactory(() => ProductBloc(repository: sl()));
}
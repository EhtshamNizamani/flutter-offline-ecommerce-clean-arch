import 'package:offline_first_ecommerce/features/auth/domain/entities/auth.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_ds.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Auth> getAuth() {
    // TODO: implement getAuth
    throw UnimplementedError();
  }
}
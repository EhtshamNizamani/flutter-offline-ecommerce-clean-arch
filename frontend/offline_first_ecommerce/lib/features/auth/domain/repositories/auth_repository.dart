import '../entities/auth.dart';

abstract class AuthRepository {
  Future<Auth> getAuth();
}
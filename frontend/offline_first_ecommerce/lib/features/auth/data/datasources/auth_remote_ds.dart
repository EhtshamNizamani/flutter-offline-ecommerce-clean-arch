import '../../../../core/api/api_service.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> register(String name, String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService; // Consistent with Product DS
  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    // ApiService ka post method use ho raha hai
    final response = await apiService.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return response.data; // Response data return karega
  }

  @override
  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await apiService.post('/auth/register', data: {
      'name': name,
      'email': email,
      'password': password,
    });
    return response.data;
  }
}

// --- BLoC ---
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first_ecommerce/core/service/token_service.dart';
import 'package:offline_first_ecommerce/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/bloc/auth_event.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/bloc/auth_state.dart';
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRemoteDataSource remoteDS;
  final TokenService tokenService;

  AuthBloc({required this.remoteDS, required this.tokenService}) : super(AuthInitial()) {
    
    // 1. Check Auto-Login (App start hone par)
    on<AppStarted>((event, emit) async {
      final token = await tokenService.getAccessToken();
      if (token != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });

    // 2. Login Logic
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await remoteDS.login(event.email, event.password);
        
        // Tokens save karna aapki service se
        await tokenService.saveTokens(
          accessToken: response['accessToken'],
          refreshToken: response['refreshToken'],
        );
        
        emit(Authenticated());
      } catch (e) {
        emit(AuthError("Login failed. Check your credentials."));
      }
    });

    // 3. Logout
    on<LogoutRequested>((event, emit) async {
      await tokenService.clearTokens();
      emit(Unauthenticated());
    });
  }
}

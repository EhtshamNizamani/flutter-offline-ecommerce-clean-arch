abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class Authenticated extends AuthState {}
class Unauthenticated extends AuthState {} // For Splash screen check
class AuthError extends AuthState { final String message; AuthError(this.message); }

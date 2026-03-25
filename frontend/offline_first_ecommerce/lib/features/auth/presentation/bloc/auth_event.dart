abstract class AuthEvent {}
class AppStarted extends AuthEvent {} // Auto-login check ke liye
class LoginRequested extends AuthEvent { final String email, password; LoginRequested(this.email, this.password); }
class LogoutRequested extends AuthEvent {}

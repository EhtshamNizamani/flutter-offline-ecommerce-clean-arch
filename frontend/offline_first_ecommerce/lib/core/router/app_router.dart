import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/pages/login_page.dart';
import 'package:offline_first_ecommerce/features/cart/presentation/pages/cart_page.dart';
import 'package:offline_first_ecommerce/features/product/presentation/pages/product_page.dart';
import 'package:offline_first_ecommerce/features/splash.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/bloc/auth_state.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    // BLoC ki state change par router ko refresh karega
    refreshListenable: GoRouterRefreshStream(authBloc.stream),

    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) => const ProductPage(),
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartPage(),
      ),
    ],

    redirect: (context, state) {
      final authState = authBloc.state;
      final location = state.matchedLocation;

      // Agar App abhi startup check kar rahi hai
      if (authState is AuthInitial) return null;
      print(  "Redirect Check: Current Location: ${state.name}, Auth State: ${authBloc.state}");  

      // AGAR USER LOGIN HAI
      if (authState is Authenticated) {
        // Agar login hai aur login page ya splash par hai, to products bhej do
        if (location == '/login' || location == '/') return '/products';
      }

      // AGAR USER LOGIN NAHI HAI
      if (authState is Unauthenticated || authState is AuthError) {
        // Agar login nahi hai aur kisi protected page par jane ki koshish kare, to login bhej do
        if (location != '/login') return '/login';
      }

      return null;
    },
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }
  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/bloc/auth_event.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/pages/login_page.dart';
import 'package:offline_first_ecommerce/features/product/presentation/pages/product_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // App start hote hi token check karo
    context.read<AuthBloc>().add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProductPage()));
        } else if (state is Unauthenticated || state is AuthError) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // Yahan aap apna Logo laga sakte hain
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:offline_first_ecommerce/core/theme/app_theme.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/bloc/auth_event.dart';
import 'package:offline_first_ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:offline_first_ecommerce/features/cart/presentation/bloc/cart_event.dart';
import 'package:offline_first_ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:offline_first_ecommerce/features/product/presentation/bloc/product_event.dart';
import 'package:offline_first_ecommerce/features/splash.dart';
import 'package:offline_first_ecommerce/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // DI aur Isar initialization

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProductBloc>()..add(GetProductsEvent()),
        ),
        BlocProvider(create: (context) => sl<CartBloc>()..add(LoadCart())),
        // App started event yahan call hoga auto-login ke liye
        BlocProvider(create: (context) => sl<AuthBloc>()..add(AppStarted())),
      ],
      // YAHAN SplashScreen nahi, balkay MyApp aayega
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Offline First E-commerce',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          // APP KI ENTRY POINT SplashScreen HOGI
          home: const SplashScreen(),
        );
      },
    );
  }
}

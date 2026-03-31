import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:offline_first_ecommerce/core/router/app_router.dart';
import 'package:offline_first_ecommerce/core/theme/app_theme.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/bloc/auth_event.dart';
import 'package:offline_first_ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:offline_first_ecommerce/features/cart/presentation/bloc/cart_event.dart';
import 'package:offline_first_ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:offline_first_ecommerce/features/product/presentation/bloc/product_event.dart';
import 'package:offline_first_ecommerce/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // DI aur Isar initialization
  final authBloc = sl<AuthBloc>();

  runApp(
    MultiBlocProvider(
      providers: [
                BlocProvider.value(value: authBloc..add(AppStarted())), 

        BlocProvider(
          create: (context) => sl<ProductBloc>()..add(GetProductsEvent()),
        ),
        BlocProvider(create: (context) => sl<CartBloc>()..add(LoadCart())),
        // App started event yahan call hoga auto-login ke liye
      ],
      child: MyApp(authBloc: authBloc),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;
  const MyApp({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter(authBloc).router;

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: appRouter, // GO ROUTER CONFIG
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,

        );
      },
    );  }
}

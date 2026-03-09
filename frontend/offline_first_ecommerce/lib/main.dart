import 'package:flutter/material.dart';
import 'package:offline_first_ecommerce/features/product/presentation/pages/product_page.dart';
import 'package:offline_first_ecommerce/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // Dependency Injection aur Isar init
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Offline First E-commerce',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ProductPage(),
    );
  }
}

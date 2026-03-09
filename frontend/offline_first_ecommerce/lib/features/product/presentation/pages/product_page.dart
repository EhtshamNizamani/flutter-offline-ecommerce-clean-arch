import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first_ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:offline_first_ecommerce/features/product/presentation/bloc/product_event.dart';
import 'package:offline_first_ecommerce/features/product/presentation/bloc/product_state.dart';
import '../../../../injection_container.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductBloc>()..add(GetProductsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Shop Online/Offline')),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ListTile(
                    leading: Image.network(product.image, width: 50, errorBuilder: (c, e, s) => const Icon(Icons.error)),
                    title: Text(product.name),
                    subtitle: Text('\$${product.price}'),
                    trailing: const Icon(Icons.add_shopping_cart),
                  );
                },
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
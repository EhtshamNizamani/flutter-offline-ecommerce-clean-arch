import 'package:cached_network_image/cached_network_image.dart';
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
        appBar: AppBar(
          title: const Text('Shop Online/Offline'),
          actions: [
            // Ek indicator dikhana ke app offline hai ya online (Optional but Cool)
            const Icon(Icons.wifi_off, color: Colors.grey, size: 18), 
            const SizedBox(width: 10),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              // AGAR PRODUCTS KHALI HAIN
              if (state.products.isEmpty) {
                return const Center(child: Text("No products found"));
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProductBloc>().add(GetProductsEvent());
                },
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: product.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorWidget: (c, e, s) => const Icon(Icons.error),
                        ),
                      ),
                      title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('\$${product.price}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          // TODO: Add to Cart Logic
                        },
                      ),
                    );
                  },
                ),
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
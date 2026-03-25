import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first_ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:offline_first_ecommerce/features/cart/presentation/bloc/cart_event.dart';
import 'package:offline_first_ecommerce/features/cart/presentation/bloc/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) return const Center(child: CircularProgressIndicator());
          if (state is CartLoaded) {
            if (state.items.isEmpty) return const Center(child: Text("Cart is empty"));
            
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return ListTile(
                        leading: Image.network(item.image, width: 50),
                        title: Text(item.name),
                        subtitle: Text('\$${item.price} x ${item.quantity}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => context.read<CartBloc>().add(RemoveFromCart(item.productId)),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total: \$${state.totalAmount.toStringAsFixed(2)}', 
                           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ElevatedButton(onPressed: () {}, child: const Text("Checkout")),
                    ],
                  ),
                )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first_ecommerce/features/cart/presentation/bloc/cart_event.dart';
import 'package:offline_first_ecommerce/features/cart/presentation/bloc/cart_state.dart';
import '../../domain/repositories/cart_repository.dart';

// --- BLoC ---
class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc({required this.repository}) : super(CartLoading()) {
    on<LoadCart>((event, emit) async {
      emit(CartLoading());
      final result = await repository.getCartItems();
      result.fold(
        (l) => emit(CartError(l)),
        (items) {
          double total = items.fold(0, (sum, item) => sum + item.totalPrice);
          emit(CartLoaded(items, total));
        },
      );
    });

    on<AddToCart>((event, emit) async {
      await repository.addToCart(event.item);
      add(LoadCart()); // UI refresh karne ke liye
    });

    on<RemoveFromCart>((event, emit) async {
      await repository.removeFromCart(event.productId);
      add(LoadCart());
    });
  }
}
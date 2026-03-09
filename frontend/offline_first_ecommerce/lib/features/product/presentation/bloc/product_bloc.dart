import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<GetProductsEvent>((event, emit) async {
      emit(ProductLoading());
      
      final result = await repository.getProducts();
      
      result.fold(
        (failure) => emit(ProductError(failure)),
        (products) => emit(ProductLoaded(products)),
      );
    });
  }
}
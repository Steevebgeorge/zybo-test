import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zybo_test/models/products_model.dart';
import 'package:zybo_test/repositories/products.dart';

part 'fetch_products_event.dart';
part 'fetch_products_state.dart';

class FetchProductsBloc extends Bloc<FetchProductsEvent, FetchProductsState> {
  final ProductRepository repository = ProductRepository();

  FetchProductsBloc() : super(FetchProductsInitial()) {
    on<ProductsRequested>((event, emit) async {
      emit(FetchProductsLoading());
      try {
        final products = await repository.fetchProducts();
        emit(FetchProductsSuccess(products: products));
      } catch (e) {
        emit(FetchProductsError(message: e.toString()));
      }
    });

    on<SearchProducts>((event, emit) async {
      emit(FetchProductsLoading());
      try {
        final results = await repository.searchProducts(event.query);
        emit(FetchProductsSuccess(products: results));
      } catch (e) {
        emit(FetchProductsError(message: e.toString()));
      }
    });
  }
}

part of 'fetch_products_bloc.dart';

sealed class FetchProductsEvent {}

class ProductsRequested extends FetchProductsEvent {}

class SearchProducts extends FetchProductsEvent {
  final String query;
  SearchProducts(this.query);
}

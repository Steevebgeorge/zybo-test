import 'package:zybo_test/models/products_model.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<ProductModel> products;
  WishlistLoaded(this.products);
}

class WishlistError extends WishlistState {
  final String message;
  WishlistError(this.message);
}

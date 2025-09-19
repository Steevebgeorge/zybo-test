import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zybo_test/repositories/wishlist.dart';

import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository repo = WishlistRepository();

  WishlistBloc() : super(WishlistInitial()) {
    on<LoadWishlist>((event, emit) async {
      emit(WishlistLoading());
      try {
        final products = await repo.fetchWishlist();
        emit(WishlistLoaded(products));
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });

    on<ToggleWishlist>((event, emit) async {
      try {
        await repo.toggleWishlist(event.productId);
        final products = await repo.fetchWishlist();
        emit(WishlistLoaded(products));
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });
  }
}

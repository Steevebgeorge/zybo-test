import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zybo_test/blocs/wishlist_bloc/bloc/wishlist_bloc.dart';
import 'package:zybo_test/blocs/wishlist_bloc/bloc/wishlist_event.dart';
import 'package:zybo_test/blocs/wishlist_bloc/bloc/wishlist_state.dart';
import 'package:zybo_test/widgets/product_box.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<WishlistBloc>().add(LoadWishlist());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("My Wishlist")),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WishlistError) {
            return Center(child: Text(state.message));
          } else if (state is WishlistLoaded) {
            if (state.products.isEmpty) {
              return Center(
                  child: Text(
                "No items in wishlist",
                style: GoogleFonts.oxygen(),
              ));
            }
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return ProductContainer(product: state.products[index]);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

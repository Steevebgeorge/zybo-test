import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zybo_test/blocs/wishlist_bloc/bloc/wishlist_bloc.dart';
import 'package:zybo_test/blocs/wishlist_bloc/bloc/wishlist_event.dart';
import 'package:zybo_test/models/products_model.dart';

class ProductContainer extends StatelessWidget {
  final ProductModel product;
  const ProductContainer({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: AspectRatio(
                  aspectRatio: 1, // makes it square like your design
                  child: Image.network(
                    product.featuredImage,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey),
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2));
                    },
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  onPressed: () {
                    context
                        .read<WishlistBloc>()
                        .add(ToggleWishlist(product.id));
                  },
                  icon: Icon(
                    Icons.favorite_outlined,
                    size: 30,
                  ),
                  color: Color(0xFF5E5BE2),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Prices Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text(
                  "₹${product.mrp.toInt()}",
                  style: GoogleFonts.oxygen(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "₹${product.salePrice.toInt()}",
                  style: GoogleFonts.oxygen(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5E5BE2),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(Icons.star, size: 18, color: Colors.orange),
                    SizedBox(width: 3),
                    Text(
                      "4.5",
                      style: GoogleFonts.oxygen(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.oxygen(
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

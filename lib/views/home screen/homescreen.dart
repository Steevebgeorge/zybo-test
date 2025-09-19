import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zybo_test/blocs/fetch%20products/bloc/fetch_products_bloc.dart';
import 'package:zybo_test/models/products_model.dart';
import 'package:zybo_test/widgets/banner.dart';
import 'package:zybo_test/widgets/product_box.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController searchController = TextEditingController();

    context.read<FetchProductsBloc>().add(ProductsRequested());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.06),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(2, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              context
                                  .read<FetchProductsBloc>()
                                  .add(SearchProducts(value));
                            } else {
                              context
                                  .read<FetchProductsBloc>()
                                  .add(ProductsRequested());
                            }
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(color: Colors.grey),
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.search, color: Colors.grey),
                          onPressed: () {
                            final query = searchController.text.trim();
                            if (query.isNotEmpty) {
                              context
                                  .read<FetchProductsBloc>()
                                  .add(SearchProducts(query));
                            } else {
                              context
                                  .read<FetchProductsBloc>()
                                  .add(ProductsRequested());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
              BannerCarousel(),
              SizedBox(height: size.height * 0.03),
              Text(
                'Popular Product',
                style: GoogleFonts.oxygen(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              BlocBuilder<FetchProductsBloc, FetchProductsState>(
                builder: (context, state) {
                  if (state is FetchProductsLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is FetchProductsError) {
                    return Center(
                        child: Text(state.message,
                            style: const TextStyle(color: Colors.red)));
                  } else if (state is FetchProductsSuccess) {
                    final products = state.products;
                    if (products.isEmpty) {
                      return Center(
                        child: Text("No products found"),
                      );
                    }
                    return GridView.builder(
                      itemCount: products.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final ProductModel product = products[index];
                        return ProductContainer(product: product);
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

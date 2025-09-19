import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zybo_test/blocs/banner%20bloc/bloc/banners_bloc.dart';
import 'package:zybo_test/models/banner_model.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentIndex = 0; 

  @override
  void initState() {
    super.initState();
    context.read<BannersBloc>().add(BannersRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersBloc, BannersState>(
      builder: (context, state) {
        if (state is BannersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BannersLoadingError) {
          return Center(
              child: Text("Failed to load banners: ${state.message}"));
        } else if (state is BannersLoadingSuccess) {
          final List<BannerModel> banners = state.banners;

          if (banners.isEmpty) {
            return const Center(child: Text("No banners available"));
          }

          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: banners.map((banner) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      banner.image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 8),

              // Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(banners.length, (index) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Colors.black87
                          : Colors.black26,
                    ),
                  );
                }),
              ),
            ],
          );
        }

        return const SizedBox.shrink(); // fallback
      },
    );
  }
}

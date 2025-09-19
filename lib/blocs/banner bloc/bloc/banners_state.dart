part of 'banners_bloc.dart';

sealed class BannersState {}

final class BannersInitial extends BannersState {}

final class BannersLoading extends BannersState {}

final class BannersLoadingSuccess extends BannersState {
  final List<BannerModel> banners;

  BannersLoadingSuccess({required this.banners});
}

final class BannersLoadingError extends BannersState {
  final String message;

  BannersLoadingError({required this.message});
}

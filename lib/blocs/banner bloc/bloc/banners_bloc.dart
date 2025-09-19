import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zybo_test/models/banner_model.dart';
import 'package:zybo_test/repositories/banner.dart';

part 'banners_event.dart';
part 'banners_state.dart';

class BannersBloc extends Bloc<BannersEvent, BannersState> {
  final FetchBannerRepository repository = FetchBannerRepository();
  BannersBloc() : super(BannersInitial()) {
    on<BannersRequested>(_bannersrequested);
  }
  Future<void> _bannersrequested(
      BannersRequested event, Emitter<BannersState> emit) async {
    emit(BannersLoading());
    try {
      final List<BannerModel> banners = await repository.fetchBanners();
      emit(BannersLoadingSuccess(banners: banners));
    } catch (e) {
      emit(BannersLoadingError(message: e.toString()));
    }
  }
}

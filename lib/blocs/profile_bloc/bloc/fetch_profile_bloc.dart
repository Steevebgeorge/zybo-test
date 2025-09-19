import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zybo_test/blocs/profile_bloc/bloc/fetch_profile_event.dart';
import 'package:zybo_test/blocs/profile_bloc/bloc/fetch_profile_state.dart';
import 'package:zybo_test/repositories/profile.dart';

class FetchProfileBloc extends Bloc<FetchProfileEvent, FetchProfileState> {
  final ProfileRepository repository = ProfileRepository();

  FetchProfileBloc() : super(FetchProfileInitial()) {
    on<FetchProfileRequested>(_fetchProfileRequested);
  }

  Future<void> _fetchProfileRequested(
      FetchProfileRequested event, Emitter<FetchProfileState> emit) async {
    emit(FetchProfileLoading());
    try {
      final data = await repository.fetchUserData();
      if (data != null) {
        emit(FetchProfileSuccess(userData: data));
      } else {
        emit(FetchProfileError(message: "No user data found"));
      }
    } catch (e) {
      emit(FetchProfileError(message: e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zybo_test/models/verifyusermodel.dart';
import 'package:zybo_test/repositories/verify.dart';

part 'verify_user_event.dart';
part 'verify_user_state.dart';

class VerifyUserBloc extends Bloc<VerifyUserEvent, VerifyUserState> {
  final VerifyRepository repository = VerifyRepository();

  VerifyUserBloc() : super(VerifyUserInitial()) {
    on<VerifyRequested>(_verifyRequested);
  }

  Future<void> _verifyRequested(
      VerifyRequested event, Emitter<VerifyUserState> emit) async {
    emit(VerifyUserLoading());
    try {
      final VerifyUserModel user =
          await repository.verifyUser(event.phoneNumber);
      emit(VerifyUserSuccess(user: user));
    } catch (e) {
      emit(VerifyUserError(message: e.toString()));
    }
  }
}

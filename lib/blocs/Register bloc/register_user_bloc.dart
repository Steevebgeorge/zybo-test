import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zybo_test/models/registermodel.dart';
import 'package:zybo_test/repositories/register.dart';

part 'register_user_event.dart';
part 'register_user_state.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {
  final RegisterUserRepository repository = RegisterUserRepository();
  RegisterUserBloc() : super(RegisterUserInitial()) {
    on<RegisterUserRequested>(_userRegisRequested);
  }

  Future<void> _userRegisRequested(
      RegisterUserRequested event, Emitter<RegisterUserState> emit) async {
    emit(RegisterUserLoading());
    try {
      final RegisterUserModel user =
          await repository.registerUser(event.phoneNumber, event.name);
      emit(RegisterUserSuccess(user: user));
    } catch (e) {
      RegisterUserError(message: e.toString());
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zybo_test/models/loginmodel.dart';
import 'package:zybo_test/repositories/login.dart';

part 'login_user_event.dart';
part 'login_user_state.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  final LoginRepository repository = LoginRepository();

  LoginUserBloc() : super(LoginUserInitial()) {
    on<LoginUserRequested>(_userLoginRequested);
  }

  Future<void> _userLoginRequested(
      LoginUserRequested event, Emitter<LoginUserState> emit) async {
    emit(LoginUserLoading());
    try {
      final LoginModel user = await repository.loginUser(event.phoneNumber);
      emit(LoginUserSuccess(user: user));
    } catch (e) {
      emit(LoginUserError(message: e.toString()));
    }
  }
}

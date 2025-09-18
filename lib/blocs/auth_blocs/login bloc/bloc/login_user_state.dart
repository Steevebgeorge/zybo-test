part of 'login_user_bloc.dart';

sealed class LoginUserState {}

final class LoginUserInitial extends LoginUserState {}

final class LoginUserLoading extends LoginUserState {}

final class LoginUserSuccess extends LoginUserState {
  final LoginModel user;

  LoginUserSuccess({required this.user});
}

final class LoginUserError extends LoginUserState {
  final String message;

  LoginUserError({required this.message});
}

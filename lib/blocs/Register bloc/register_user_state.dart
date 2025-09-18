part of 'register_user_bloc.dart';

sealed class RegisterUserState {}

final class RegisterUserInitial extends RegisterUserState {}

final class RegisterUserLoading extends RegisterUserState {}

final class RegisterUserSuccess extends RegisterUserState {
  final RegisterUserModel user;

  RegisterUserSuccess({required this.user});
}

final class RegisterUserError extends RegisterUserState {
  final String message;

  RegisterUserError({required this.message});
}

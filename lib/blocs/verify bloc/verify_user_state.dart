part of 'verify_user_bloc.dart';

sealed class VerifyUserState {}

final class VerifyUserInitial extends VerifyUserState {}

final class VerifyUserLoading extends VerifyUserState {}

final class VerifyUserSuccess extends VerifyUserState {
  final VerifyUserModel user;

  VerifyUserSuccess({required this.user});
}

final class VerifyUserError extends VerifyUserState {
  final String message;

  VerifyUserError({required this.message});
}

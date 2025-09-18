part of 'login_user_bloc.dart';

class LoginUserEvent {}

class LoginUserRequested extends LoginUserEvent {
  final String phoneNumber;

  LoginUserRequested({
    required this.phoneNumber,
  });
}

part of 'register_user_bloc.dart';

class RegisterUserEvent {}

class RegisterUserRequested extends RegisterUserEvent {
  final String phoneNumber;
  final String name;

  RegisterUserRequested({required this.phoneNumber, required this.name});
}

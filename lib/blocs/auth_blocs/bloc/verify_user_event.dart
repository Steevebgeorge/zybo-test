part of 'verify_user_bloc.dart';

class VerifyUserEvent {}

class VerifyRequested extends VerifyUserEvent {
  final String phoneNumber;

  VerifyRequested({required this.phoneNumber});
}

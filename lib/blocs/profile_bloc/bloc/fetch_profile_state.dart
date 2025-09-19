sealed class FetchProfileState {}

final class FetchProfileInitial extends FetchProfileState {}

final class FetchProfileLoading extends FetchProfileState {}

final class FetchProfileSuccess extends FetchProfileState {
  final Map<String, dynamic> userData;
  FetchProfileSuccess({
    required this.userData,
  });
}

final class FetchProfileError extends FetchProfileState {
  final String message;

  FetchProfileError({required this.message});
}

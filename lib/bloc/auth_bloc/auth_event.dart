part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSignInEvent extends AuthEvent {
  AuthSignInEvent({required this.user});

  final user_model.User user;
}

class AuthSignOutEvent extends AuthEvent {}

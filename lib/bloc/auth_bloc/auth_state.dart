part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSignIn extends AuthState {
  AuthSignIn({required this.user});

  final user_model.User user;
}

class AuthSignOut extends AuthState {}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart' as user_model;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthSignInEvent>((event, emit) {
      emit(AuthSignIn(user: event.user));
    });
    on<AuthSignOutEvent>((event, emit) {
      emit(AuthSignOut());
    });
  }
}

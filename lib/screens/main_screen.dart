import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc/auth_bloc.dart';
import '../models/user.dart' as UserModel;
import 'auth_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        BlocProvider.of<AuthBloc>(context).add(AuthSignOutEvent());
      } else {
        BlocProvider.of<AuthBloc>(context).add(
          AuthSignInEvent(
            user: UserModel.User(firebaseUid: user.uid),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSignIn) {
          return const HomeScreen();
        }
        if (state is AuthSignOut) {
          return const AuthScreen();
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
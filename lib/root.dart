import 'package:aistcargo/bloc/auth_bloc/auth_bloc.dart';
import 'package:aistcargo/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:phone_form_field/phone_form_field.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = AuthBloc();
    return BlocProvider(
      create: (context) => authBloc,
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          PhoneFieldLocalization.delegate,
        ],
        supportedLocales: const [
          Locale('ru', 'RU'),
        ],
        title: 'AistCargo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AuthScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Авторизация AISTCARGO',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Введите номер телефона',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              PhoneFormField(
                defaultCountry: IsoCode.RU,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    gapPadding: 1,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                isCountryChipPersistent: true,
              ),
              const SizedBox(
                height: 30,
              ),
              const OutlinedButton(
                onPressed: null,
                child: Text('Подтвердить вход'),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Нажимая “Продолжить” Вы принимаете Пользовательское соглашение',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

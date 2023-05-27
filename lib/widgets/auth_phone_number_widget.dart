import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class AuthPhoneNumberWidget extends StatelessWidget {
  final PhoneController phoneNumberController;
  final bool loading;
  final Function() submit;

  const AuthPhoneNumberWidget({
    super.key,
    required this.phoneNumberController,
    required this.loading,
    required this.submit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          enabled: !loading,
          controller: phoneNumberController,
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
        OutlinedButton(
          onPressed: loading ? null : submit,
          child: loading
              ? Container(
                  width: 24,
                  height: 24,
                  padding: const EdgeInsets.all(2.0),
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : const Text('Подтвердить вход'),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Нажимая “Продолжить” Вы принимаете Пользовательское соглашение',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
        ),
      ],
    );
  }
}

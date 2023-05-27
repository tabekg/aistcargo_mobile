import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class AuthVerificationCodeWidget extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const AuthVerificationCodeWidget({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  State<AuthVerificationCodeWidget> createState() =>
      _AuthVerificationCodeWidgetState();
}

class _AuthVerificationCodeWidgetState
    extends State<AuthVerificationCodeWidget> {
  TextEditingController pinController = TextEditingController();
  final focusNode = FocusNode();
  bool loading = false;

  void onComplete(String code) async {
    if (loading) {
      return;
    }
    setState(() {
      loading = true;
    });
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: code,
      );
      await auth.signInWithCredential(credential);
    } catch (_) {
      setState(() {
        loading = false;
      });
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Введите код из SMS',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Мы отправили сообщение на номер телефона ${widget.phoneNumber}',
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 14,
        ),
        // VerificationCode(
        //   textStyle: Theme.of(context)
        //       .textTheme
        //       .bodyMedium!
        //       .copyWith(color: Theme.of(context).primaryColor),
        //   keyboardType: TextInputType.number,
        //   underlineColor: Colors.amber,
        //   length: 6,
        //   digitsOnly: true,
        //   fullBorder: true,
        //   itemSize: 35,
        //   cursorColor: Colors.blue,
        //   margin: const EdgeInsets.all(6),
        //   onCompleted: widget.onCompleted,
        //   onEditing: (bool value) {
        //     setState(() {
        //       _onEditing = value;
        //     });
        //     if (!_onEditing) {
        //       FocusScope.of(context).unfocus();
        //     }
        //   },
        // ),
        Pinput(
          autofocus: true,
          enabled: !loading,
          controller: pinController,
          focusNode: focusNode,
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
          listenForMultipleSmsOnAndroid: true,
          defaultPinTheme: defaultPinTheme,
          hapticFeedbackType: HapticFeedbackType.lightImpact,
          onCompleted: onComplete,
          length: 6,
          cursor: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 9),
                width: 22,
                height: 1,
                color: focusedBorderColor,
              ),
            ],
          ),
          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration!.copyWith(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: focusedBorderColor),
            ),
          ),
          submittedPinTheme: defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration!.copyWith(
              color: fillColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: focusedBorderColor),
            ),
          ),
          errorPinTheme: defaultPinTheme.copyBorderWith(
            border: Border.all(color: Colors.redAccent),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        OutlinedButton(
          onPressed: null,
          child: loading
              ? Container(
                  width: 24,
                  height: 24,
                  padding: const EdgeInsets.all(2.0),
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : const Text('Запросить код повторно'),
        ),
      ],
    );
  }
}

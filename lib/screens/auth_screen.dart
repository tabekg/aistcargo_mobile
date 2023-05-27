import 'package:aistcargo/widgets/auth_phone_number_widget.dart';
import 'package:aistcargo/widgets/auth_verification_code_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AuthScreen> {
  PhoneController phoneNumberController = PhoneController(
    const PhoneNumber(isoCode: IsoCode.RU, nsn: ''),
  );
  String? verificationId;
  bool loading = false;

  void submit() async {
    if (phoneNumberController.value == null || loading) {
      return;
    }
    if (!phoneNumberController.value!.isValid()) {
      return;
    }
    FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      loading = true;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumberController.value!.international,
      verificationCompleted: (PhoneAuthCredential credential) async {
        setState(() {
          loading = false;
          verificationId = credential.verificationId;
        });
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          loading = false;
        });
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
        print(e.code);
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          loading = false;
          this.verificationId = verificationId;
        });
        print(verificationId);
        print(resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
      },
    );
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: verificationId == null
              ? AuthPhoneNumberWidget(
                  loading: loading,
                  submit: submit,
                  phoneNumberController: phoneNumberController,
                )
              : AuthVerificationCodeWidget(
                  verificationId: verificationId!,
                  phoneNumber: phoneNumberController.value!.international,
                ),
        ),
      ),
    );
  }
}

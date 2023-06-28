import 'package:aistcargo/bloc/auth_bloc/auth_bloc.dart';
import 'package:aistcargo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/user.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  UserGenderEnum? gender;
  bool agreement = false;
  String fullName = '';

  bool loading = false;

  TextEditingController fullNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fullNameController.addListener(() {
      setState(() {
        fullName = fullNameController.text;
      });
    });

    AuthState state = BlocProvider.of<AuthBloc>(context).state;
    if (state is AuthSignIn) {
      setState(() {
        fullName = state.user.fullName ?? '';
        gender = state.user.gender;
        agreement = state.user.gender != null;
      });
      fullNameController.text = state.user.fullName ?? '';
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  save() {
    if (loading || fullName.isEmpty || gender == null || agreement == false) {
      return;
    }
    setState(() {
      loading = true;
    });
    updateProfile(
      fullName: fullName,
      gender: gender!,
    ).then((v) {
      if (v != null) {
        BlocProvider.of<AuthBloc>(context).add(AuthSignInEvent(user: v));
      }
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Укажите основную информацию, чтобы завоевать больше доверие людей',
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'Фото пользователя',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300]!,
                ),
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              width: 100,
              height: 100,
              child: const Center(
                child: Text('+'),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: TextField(
            controller: fullNameController,
            decoration: const InputDecoration(
              labelText: 'Полное имя',
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: const Text("Мужской"),
                  value: UserGenderEnum.male,
                  groupValue: gender,
                  dense: true,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  dense: true,
                  title: const Text("Женский"),
                  value: UserGenderEnum.female,
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CheckboxListTile(
            title: Text(
              "Даю согласие на обработку персональных данных",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            value: agreement,
            onChanged: (newValue) {
              setState(() {
                agreement = newValue ?? false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 70,
            vertical: 12,
          ),
          child: OutlinedButton(
            onPressed:
                agreement && fullName.isNotEmpty && gender != null && !loading
                    ? save
                    : null,
            child: Text(loading ? 'Подожите...' : 'Сохранить'),
          ),
        ),
      ],
    );
  }
}

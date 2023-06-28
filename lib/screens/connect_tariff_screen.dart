import 'package:aistcargo/models/delivery.dart';
import 'package:aistcargo/screens/select_plan_screen.dart';
import 'package:flutter/material.dart';

class ConnectTariffScreen extends StatelessWidget {
  const ConnectTariffScreen({
    super.key,
    required this.typeName,
  });

  final DeliveryTypeEnum typeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Подключите подписку')),
      body: Column(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Ваша доставка успешно добавлено. Но она пока не опубликована. Чтобы опубликовать подключите подписку.',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectPlanScreen(
                      typeName: typeName,
                    ),
                  ),
                );
              },
              child: const Text('Выбрать подписку'),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:aistcargo/models/delivery.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryResultItemWidget extends StatelessWidget {
  const DeliveryResultItemWidget({
    super.key,
    required this.item,
  });

  final Delivery item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        right: 4,
        bottom: 4,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Откуда: ${item.fromPoint!.titleRu}'),
                    Text('Куда: ${item.toPoint!.titleRu}'),
                    Text('Когда: ${item.dateTime}'),
                    Text('Тип: ${item.typeTitle}'),
                  ],
                ),
              ),
              FloatingActionButton(
                elevation: 1,
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                onPressed: () {
                  launchUrl(Uri.parse('tel:+${item.user!.phoneNumber}'));
                },
                tooltip: 'Позвонить',
                child: const Icon(
                  Icons.call,
                  size: 24.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

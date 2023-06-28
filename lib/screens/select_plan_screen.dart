import 'package:aistcargo/models/delivery.dart';
import 'package:aistcargo/utils/config.dart';
import 'package:aistcargo/utils/index.dart';
import 'package:aistcargo/utils/requester.dart';
import 'package:flutter/material.dart';

class PriceCardWidget extends StatelessWidget {
  const PriceCardWidget({
    super.key,
    required this.onTap,
    required this.color,
    required this.price,
    required this.days,
  });

  final Function(int days) onTap;
  final Color color;
  final int price;
  final int days;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: 100,
        height: 100,
        child: InkWell(
          onTap: () => onTap(days),
          borderRadius: BorderRadius.circular(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${price}Р',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'за $days дней',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectPlanScreen extends StatefulWidget {
  const SelectPlanScreen({
    super.key,
    required this.typeName,
  });

  final DeliveryTypeEnum typeName;

  @override
  State<SelectPlanScreen> createState() => _SelectPlanScreenState();
}

class _SelectPlanScreenState extends State<SelectPlanScreen> {
  bool loading = false;

  void subscribe(int days) {
    setState(() {
      loading = true;
    });

    print(days);
    showToastError('Тестовое подключение...');

    Requester().post('/user/subscribe/test', body: {
      'delivery_type': widget.typeName.name,
      'days': days,
    }).then((value) {
      print(value.status);
      if (value.status == 'success') {
        showToastSuccess('Успешно подключено!');
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DeliveryType deliveryType =
        deliveryTypesList.getByName(widget.typeName.name)!;

    return Scaffold(
      appBar: AppBar(title: const Text('Подключить подписку')),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            deliveryType.imageAsset,
            height: 79,
          ),
          const SizedBox(
            height: 34,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Чтобы воспользоватся нашей услугой подключить подписки. Чем больше срок, тем больше выгода',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          if (loading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (!loading)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PriceCardWidget(
                  color: const Color(0x4DFFB900),
                  onTap: subscribe,
                  price: deliveryType.variants[30]!,
                  days: 30,
                ),
                PriceCardWidget(
                  color: const Color(0x4D00A3EE),
                  onTap: subscribe,
                  price: deliveryType.variants[90]!,
                  days: 90,
                ),
              ],
            ),
          if (!loading)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PriceCardWidget(
                  color: const Color(0x4DF74E1E),
                  onTap: subscribe,
                  price: deliveryType.variants[180]!,
                  days: 180,
                ),
                PriceCardWidget(
                  color: const Color(0x4D80BB00),
                  onTap: subscribe,
                  price: deliveryType.variants[365]!,
                  days: 365,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

import 'package:aistcargo/models/delivery.dart';
import 'package:aistcargo/utils/config.dart';
import 'package:aistcargo/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:yookassa_payments_flutter/yookassa_payments_flutter.dart';

class PriceCardWidget extends StatelessWidget {
  const PriceCardWidget({
    super.key,
    required this.onTap,
    required this.color,
    required this.price,
    required this.days,
  });

  final Function(int days, int price) onTap;
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
          onTap: () => onTap(days, price),
          borderRadius: BorderRadius.circular(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${price}₽',
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

  void subscribe(int days, int price) {
    // setState(() {
    //   loading = true;
    // });
    showToastError('Тестовое подключение...');

    var clientApplicationKey =
        "test_OTQ2NDg59jlL6Yg0c1tQJk1fOewqQHu_nQKIQgl2fx8";
    var amount = Amount(value: price.toDouble(), currency: Currency.rub);
    var shopId = "946489";
    var tokenizationModuleInputData = TokenizationModuleInputData(
      clientApplicationKey: clientApplicationKey,
      title: "Подключение подписку",
      subtitle: "Оплата за подписку за $days дней ($price₽)",
      amount: amount,
      shopId: shopId,
      savePaymentMethod: SavePaymentMethod.off,
      moneyAuthClientId: 'cjgq1f49q7e2b3bosduiue0n87npaavb',
      tokenizationSettings: const TokenizationSettings(PaymentMethodTypes.all),
    );

    YookassaPaymentsFlutter.tokenization(tokenizationModuleInputData)
        .then((value) {
      print(value);
    });

    // Requester().post('/user/subscribe/test', body: {
    //   'delivery_type': widget.typeName.name,
    //   'days': days,
    // }).then((value) {
    //   print(value.status);
    //   if (value.status == 'success') {
    //     showToastSuccess('Успешно подключено!');
    //     Navigator.of(context).popUntil((route) => route.isFirst);
    //   }
    // }).whenComplete(() {
    //   setState(() {
    //     loading = false;
    //   });
    // });
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

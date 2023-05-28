import 'package:aistcargo/screens/create_delivery_screen.dart';
import 'package:aistcargo/utils/config.dart';
import 'package:aistcargo/widgets/home_box_item_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DeliveryType airplainType = deliveryTypesList.getByName('airplain')!;
    final DeliveryType carType = deliveryTypesList.getByName('car')!;
    final DeliveryType truckType = deliveryTypesList.getByName('truck')!;

    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 24,
          ),
          Image.asset(
            'assets/logo-aist-cargo.png',
            height: 103,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'AISTCARGO',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: const Color(0xFF00A3EE)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 22,
          ),
          Text(
            'Разместите информацию о Ваших поездках, чтобы помочь другим людям с доставкой посылок',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 70,
          ),
          RotationTransition(
            turns: const AlwaysStoppedAnimation(-45 / 360),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HomeBoxItemWidget(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CreateDeliveryScreen(
                            deliveryType: carType,
                          ),
                        ),
                      ),
                      color: carType.color,
                      children: [
                        Image.asset(
                          carType.imageAsset,
                          height: 35,
                        ),
                        Text(
                          carType.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                    HomeBoxItemWidget(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CreateDeliveryScreen(
                            deliveryType: airplainType,
                          ),
                        ),
                      ),
                      color: airplainType.color,
                      children: [
                        Image.asset(
                          airplainType.imageAsset,
                          height: 35,
                        ),
                        Text(
                          airplainType.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HomeBoxItemWidget(
                      onTap: () => null,
                      color: const Color(0x4DFFB900),
                      children: [
                        Text(
                          'ПОИСК',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          'доставщика',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                    HomeBoxItemWidget(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CreateDeliveryScreen(
                            deliveryType: truckType,
                          ),
                        ),
                      ),
                      color: truckType.color,
                      children: [
                        Image.asset(
                          truckType.imageAsset,
                          height: 35,
                        ),
                        Text(
                          truckType.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
                // ElevatedButton(
                //   child: const Text('SignOut'),
                //   onPressed: () {
                //     FirebaseAuth auth = FirebaseAuth.instance;
                //     auth.signOut();
                //   },
                // )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Создать',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}

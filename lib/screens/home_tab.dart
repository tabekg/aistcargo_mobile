import 'package:aistcargo/screens/create_delivery_screen.dart';
import 'package:aistcargo/utils/config.dart';
import 'package:aistcargo/widgets/home_box_item_widget.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    final DeliveryType airplaneType = deliveryTypesList.getByName('airplane')!;
    final DeliveryType carType = deliveryTypesList.getByName('car')!;
    final DeliveryType truckType = deliveryTypesList.getByName('truck')!;

    return ListView(
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
                      Icon(
                        carType.icon,
                        size: 35,
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
                          deliveryType: airplaneType,
                        ),
                      ),
                    ),
                    color: airplaneType.color,
                    children: [
                      Icon(
                        airplaneType.icon,
                        size: 35,
                      ),
                      Text(
                        airplaneType.title,
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
                  const HomeBoxItemWidget(
                    onTap: null,
                    color: Color(0x4DFFB900),
                    children: [
                      // Text(
                      //   'ПОИСК',
                      //   style: Theme.of(context).textTheme.bodyLarge,
                      // ),
                      // Text(
                      //   'доставщика',
                      //   textAlign: TextAlign.center,
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .bodyMedium
                      //       ?.copyWith(fontSize: 13),
                      // ),
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
                      Icon(
                        truckType.icon,
                        size: 35,
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
    );
  }
}

import 'package:flutter/material.dart';

class DeliveryType {
  String name;
  String title;
  String imageAsset;
  Map<String, int> plans;
  Color color;
  List<ParcelType> parcelTypes;
  List<int> parcelWeights;

  DeliveryType({
    required this.name,
    required this.imageAsset,
    required this.plans,
    required this.color,
    required this.title,
    required this.parcelTypes,
    required this.parcelWeights,
  });
}

class DeliveryTypesList {
  List<DeliveryType> list;

  DeliveryTypesList({required this.list});

  DeliveryType? getByName(String name) {
    try {
      return list.firstWhere((element) => element.name == name);
    } catch (_) {
      return null;
    }
  }
}

final DeliveryTypesList deliveryTypesList = DeliveryTypesList(
  list: [
    DeliveryType(
      name: 'airplain',
      title: 'Самолетом',
      imageAsset: 'assets/3280116.png',
      plans: {},
      color: const Color(0x4DF74E1E),
      parcelTypes: [
        ParcelType(title: 'Конверт', name: 'envelope'),
        ParcelType(title: 'Коробка', name: 'box'),
        ParcelType(title: 'Документ', name: 'document'),
        ParcelType(title: 'Сумка', name: 'bag'),
      ],
      parcelWeights: [1, 5, 10, 23],
    ),
    DeliveryType(
      name: 'car',
      title: 'Автомобилем',
      imageAsset: 'assets/573320.png',
      plans: {},
      color: const Color(0x4D80BB00),
      parcelTypes: [
        ParcelType(title: 'Конверт', name: 'envelope'),
        ParcelType(title: 'Коробка', name: 'box'),
        ParcelType(title: 'Документ', name: 'document'),
        ParcelType(title: 'Сумка', name: 'bag'),
        ParcelType(title: 'Другое', name: 'other'),
      ],
      parcelWeights: [50, 100, 150, 200],
    ),
    DeliveryType(
      name: 'truck',
      title: 'Грузовиком',
      imageAsset: 'assets/7637464.png',
      plans: {},
      color: const Color(0x4D00A3EE),
      parcelTypes: [],
      parcelWeights: [],
    ),
  ],
);

class ParcelType {
  String title;
  String name;

  ParcelType({
    required this.title,
    required this.name,
  });
}

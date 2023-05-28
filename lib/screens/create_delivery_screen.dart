import 'package:aistcargo/utils/config.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/point.dart';

final Map<int, String> bodyTypes = {
  400: 'Малый кузов до 400 кг.',
  1500: 'Средний кузов до 1.5 т.',
  5000: 'Большой кузов до 5 т.',
  20000: 'Фура до 20 т. и выше',
};

class CreateDeliveryScreen extends StatefulWidget {
  const CreateDeliveryScreen({super.key, required this.deliveryType});

  final DeliveryType deliveryType;

  @override
  State<CreateDeliveryScreen> createState() => _CreateDeliveryScreenState();
}

class _CreateDeliveryScreenState extends State<CreateDeliveryScreen> {
  List<S2Choice<ParcelType>> parcelTypeChoice = [];
  List<S2Choice<int>> parcelWeightChoice = [];

  ParcelType? selectedParcelType;
  int? selectedBodyType;
  int? selectedParcelWeight;
  Point? selectedFromPoint;
  Point? selectedToPoint;

  @override
  void initState() {
    super.initState();

    parcelTypeChoice = widget.deliveryType.parcelTypes
        .map(
          (e) => S2Choice<ParcelType>(value: e, title: e.title),
        )
        .toList();

    parcelWeightChoice = widget.deliveryType.parcelWeights
        .map(
          (e) => S2Choice<int>(value: e, title: 'до $e кг.'),
        )
        .toList();
  }

  List<Point> pointsList = [
    Point(title: 'Ош', id: 1),
    Point(id: 2, title: 'Бишкек'),
    Point(id: 3, title: 'Москва'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить доставку'),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            widget.deliveryType.imageAsset,
            height: 79,
          ),
          const SizedBox(
            height: 34,
          ),
          Text(
            widget.deliveryType.title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              child: Column(
                children: [
                  SmartSelect<Point>.single(
                    placeholder: 'Выберите',
                    title: widget.deliveryType.name == 'airplain'
                        ? 'Откуда'
                        : 'Откуда забрать груз',
                    selectedValue: selectedFromPoint ?? Point.empty(),
                    choiceItems: pointsList
                        .where((element) => element.id != selectedToPoint?.id)
                        .map(
                          (e) => S2Choice(
                            value: e,
                            title: e.title,
                          ),
                        )
                        .toList(),
                    onChange: (state) =>
                        setState(() => selectedFromPoint = state.value),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  SmartSelect<Point>.single(
                    placeholder: 'Выберите',
                    title: widget.deliveryType.name == 'airplain'
                        ? 'Куда'
                        : 'Куда привезти груз',
                    selectedValue: selectedToPoint ?? Point.empty(),
                    choiceItems: pointsList
                        .where((element) => element.id != selectedFromPoint?.id)
                        .map(
                          (e) => S2Choice(
                            value: e,
                            title: e.title,
                          ),
                        )
                        .toList(),
                    onChange: (state) =>
                        setState(() => selectedToPoint = state.value),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  if (widget.deliveryType.name == 'truck')
                    SmartSelect<int>.single(
                      placeholder: 'Выберите',
                      title: 'Тип кузова',
                      selectedValue: selectedBodyType ?? 0,
                      choiceItems: bodyTypes.keys
                          .map(
                            (value) => S2Choice(
                              value: value,
                              title: bodyTypes[value],
                            ),
                          )
                          .toList(),
                      onChange: (state) =>
                          setState(() => selectedBodyType = state.value),
                    ),
                  if (widget.deliveryType.name == 'truck')
                    const Divider(
                      height: 1,
                    ),
                  if (parcelTypeChoice.isNotEmpty)
                    SmartSelect<ParcelType>.single(
                      placeholder: 'Выберите',
                      title: 'Тип посылки',
                      selectedValue:
                          selectedParcelType ?? ParcelType(title: '', name: ''),
                      choiceItems: parcelTypeChoice,
                      onChange: (state) =>
                          setState(() => selectedParcelType = state.value),
                    ),
                  if (parcelTypeChoice.isNotEmpty)
                    const Divider(
                      height: 1,
                    ),
                  if (parcelWeightChoice.isNotEmpty)
                    SmartSelect<int>.single(
                      placeholder: 'Выберите',
                      title: 'Вес посылки',
                      selectedValue: selectedParcelWeight ?? 0,
                      choiceItems: parcelWeightChoice,
                      onChange: (state) =>
                          setState(() => selectedParcelWeight = state.value),
                    ),
                  if (parcelWeightChoice.isNotEmpty)
                    const Divider(
                      height: 1,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: DateTimePicker(
                            type: widget.deliveryType.name == 'truck'
                                ? DateTimePickerType.date
                                : DateTimePickerType.dateTime,
                            dateMask: widget.deliveryType.name == 'truck'
                                ? 'dd.MM.yyyy'
                                : 'dd.MM.yyyy HH:mm',
                            initialValue: DateTime.now().toString(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 30)),
                            icon: const Icon(Icons.event),
                            dateLabelText: widget.deliveryType.name == 'truck'
                                ? 'Дата отправки'
                                : 'Когда',
                            onSaved: (val) => print(val),
                          ),
                        ),
                        if (widget.deliveryType.name == 'truck')
                          const Text(
                            ' ± ',
                            style: TextStyle(fontSize: 24),
                          ),
                        if (widget.deliveryType.name == 'truck')
                          const Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('дней'),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Опишите о доставке',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                      ),
                      minLines: 4,
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.yellow, width: 2),
              ),
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "Ошибка соединения с сервером!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text(
                'Создать доставку',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}

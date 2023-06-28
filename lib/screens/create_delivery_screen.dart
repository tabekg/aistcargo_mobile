import 'package:aistcargo/api/delivery.dart';
import 'package:aistcargo/api/point.dart';
import 'package:aistcargo/models/delivery.dart';
import 'package:aistcargo/utils/config.dart';
import 'package:aistcargo/utils/index.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import '../models/point.dart';
import 'connect_tariff_screen.dart';

final Map<DeliveryBodyTypeEnum, String> bodyTypes = {
  DeliveryBodyTypeEnum.small: 'Малый кузов до 400 кг.',
  DeliveryBodyTypeEnum.medium: 'Средний кузов до 1.5 т.',
  DeliveryBodyTypeEnum.large: 'Большой кузов до 5 т.',
  DeliveryBodyTypeEnum.truck: 'Фура до 20 т. и выше',
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
  DeliveryBodyTypeEnum? selectedBodyType;
  int? selectedParcelWeight;
  Point? selectedFromPoint;
  Point? selectedToPoint;

  bool loading = false;

  TextEditingController dateTimeEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  TextEditingController plusMinusDaysEditingController =
      TextEditingController();

  List<Point> pointsList = [];

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

    final now = DateTime.now();

    dateTimeEditingController.text =
        DateTime(now.year, now.month, now.day + 1, 8).toString();

    _fetchPointsList();
  }

  void _fetchPointsList() {
    fetchPointsList().then((value) {
      setState(() {
        pointsList = value;
      });
    });
  }

  void submit() {
    if (loading) {
      return;
    }
    if (selectedFromPoint == null) {
      showToastError('Укажите откуда забрать груз!');
      return;
    }
    if (selectedToPoint == null) {
      showToastError('Укажите куда доставить груз!');
      return;
    }
    if (parcelWeightChoice.isNotEmpty && selectedParcelType == null) {
      showToastError('Укажите тип посылки!');
      return;
    }
    if (parcelWeightChoice.isNotEmpty && selectedParcelWeight == null) {
      showToastError('Укажите вес посылки!');
      return;
    }
    if (dateTimeEditingController.text.isEmpty) {
      return;
    }
    if (widget.deliveryType.name == 'truck' && selectedBodyType == null) {
      showToastError('Укажите тип кузова!');
      return;
    }
    setState(() {
      loading = true;
    });
    createDelivery(
      Delivery(
        fromPointId: selectedFromPoint!.id,
        toPointId: selectedToPoint!.id,
        description: descriptionEditingController.text,
        weight: selectedParcelWeight,
        dateTime: DateTime.parse(dateTimeEditingController.text),
        bodyType: selectedBodyType,
        type: DeliveryTypeEnum.values.firstWhere(
          (element) =>
              element.toString() ==
              'DeliveryTypeEnum.${widget.deliveryType.name}',
        ),
      ),
    ).then((value) {
      if (value?.status == DeliveryStatusEnum.pending) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ConnectTariffScreen(
              typeName: value!.type,
            ),
          ),
        );
      }
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
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
                  if (pointsList.isNotEmpty)
                    SmartSelect<Point>.single(
                      placeholder: 'Выберите',
                      title: widget.deliveryType.name == 'airplane'
                          ? 'Откуда'
                          : 'Откуда забрать груз',
                      selectedValue: selectedFromPoint ?? Point.empty(),
                      choiceItems: pointsList
                          .where((element) => element.id != selectedToPoint?.id)
                          .map(
                            (e) => S2Choice(
                              value: e,
                              title: e.titleRu,
                            ),
                          )
                          .toList(),
                      onChange: (state) =>
                          setState(() => selectedFromPoint = state.value),
                    ),
                  if (pointsList.isNotEmpty)
                    const Divider(
                      height: 1,
                    ),
                  if (pointsList.isNotEmpty)
                    SmartSelect<Point>.single(
                      placeholder: 'Выберите',
                      title: widget.deliveryType.name == 'airplane'
                          ? 'Куда'
                          : 'Куда привезти груз',
                      selectedValue: selectedToPoint ?? Point.empty(),
                      choiceItems: pointsList
                          .where(
                              (element) => element.id != selectedFromPoint?.id)
                          .map(
                            (e) => S2Choice(
                              value: e,
                              title: e.titleRu,
                            ),
                          )
                          .toList(),
                      onChange: (state) =>
                          setState(() => selectedToPoint = state.value),
                    ),
                  if (pointsList.isNotEmpty)
                    const Divider(
                      height: 1,
                    ),
                  if (pointsList.isNotEmpty)
                    if (widget.deliveryType.name == 'truck')
                      SmartSelect<DeliveryBodyTypeEnum>.single(
                        placeholder: 'Выберите',
                        title: 'Тип кузова',
                        modalType: S2ModalType.bottomSheet,
                        selectedValue:
                            selectedBodyType ?? DeliveryBodyTypeEnum.other,
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
                      modalType: S2ModalType.bottomSheet,
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
                      modalType: S2ModalType.bottomSheet,
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
                            firstDate:
                                DateTime(now.year, now.month, now.day + 1),
                            lastDate: now.add(const Duration(days: 30)),
                            icon: const Icon(Icons.event),
                            dateLabelText: widget.deliveryType.name == 'truck'
                                ? 'Дата отправки'
                                : 'Когда',
                            controller: dateTimeEditingController,
                          ),
                        ),
                        if (widget.deliveryType.name == 'truck')
                          const Text(
                            ' ± ',
                            style: TextStyle(fontSize: 24),
                          ),
                        if (widget.deliveryType.name == 'truck')
                          Flexible(
                            flex: 1,
                            child: TextField(
                              controller: plusMinusDaysEditingController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                PlusMinusRangeTextInputFormatter(),
                              ],
                              decoration: const InputDecoration(
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
                      controller: descriptionEditingController,
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
              onPressed: loading ? null : submit,
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

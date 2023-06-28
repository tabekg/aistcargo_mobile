import 'package:aistcargo/api/delivery.dart';
import 'package:aistcargo/models/delivery.dart';
import 'package:aistcargo/widgets/delivery_result_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import '../api/point.dart';
import '../models/point.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<Point> pointsList = [];
  List<Delivery>? resultsList = [];
  bool loading = false;

  Point? selectedFromPoint;
  Point? selectedToPoint;

  @override
  void initState() {
    super.initState();

    // dateTimeEditingController.text =
    //     DateTime(now.year, now.month, now.day + 1, 8).toString();

    _fetchPointsList();
  }

  void _fetchResultsList() {
    if (loading || selectedFromPoint == null || selectedToPoint == null) {
      return;
    }
    setState(() {
      loading = true;
    });
    fetchDeliveryByQuery(selectedFromPoint!, selectedToPoint!).then((value) {
      setState(() {
        resultsList = value.isEmpty ? null : value;
      });
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  void _fetchPointsList() {
    if (loading) {
      return;
    }
    setState(() {
      loading = true;
    });
    fetchPointsList().then((value) {
      setState(() {
        pointsList = value;
      });
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: Column(
              children: [
                SmartSelect<Point>.single(
                  placeholder: 'Выберите',
                  title: 'Откуда',
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
                const Divider(
                  height: 1,
                ),
                SmartSelect<Point>.single(
                  placeholder: 'Выберите',
                  title: 'Куда',
                  selectedValue: selectedToPoint ?? Point.empty(),
                  choiceItems: pointsList
                      .where((element) => element.id != selectedFromPoint?.id)
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
                const Divider(
                  height: 1,
                ),
                TextButton.icon(
                  icon: loading
                      ? Container(
                          width: 20,
                          height: 20,
                          padding: const EdgeInsets.all(2.0),
                          child: const CircularProgressIndicator(
                            color: Colors.grey,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.search,
                          size: 24.0,
                        ),
                  onPressed: loading ? null : _fetchResultsList,
                  label: const Text('Найти доставщика'),
                ),
              ],
            ),
          ),
        ),
        ...(loading
            ? []
            : resultsList == null
                ? [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 34.0),
                        child: Text(
                          'Результата нет.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ]
                : resultsList!
                    .map(
                      (e) => DeliveryResultItemWidget(
                        item: e,
                      ),
                    )
                    .toList()),
      ],
    );
  }
}

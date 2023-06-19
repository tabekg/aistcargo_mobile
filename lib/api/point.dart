import 'package:aistcargo/models/point.dart';
import 'package:aistcargo/utils/requester.dart';

Future<List<Point>> fetchPointsList() async {
  try {
    final res = await Requester().get('/point');
    return List.castFrom(res.payload).map((e) => Point.fromJson(e)).toList();
  } catch (_) {
    print(_);
    return [];
  }
}

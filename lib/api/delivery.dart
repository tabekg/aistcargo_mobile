import 'package:aistcargo/models/delivery.dart';
import 'package:aistcargo/utils/requester.dart';

import '../models/point.dart';

Future<Delivery?> createDelivery(Delivery delivery) async {
  final res = await Requester().post('/delivery', body: {
    'from_point_id': delivery.fromPointId,
    'to_point_id': delivery.toPointId,
    'description': delivery.description,
    'datetime': delivery.dateTime.toString(),
    'weight': delivery.weight,
    'body_type': delivery.bodyType?.name,
    'delivery_type': delivery.type.name,
  });
  return Delivery.fromJson(res.payload);
}

Future<List<Delivery>> fetchDeliveryByQuery(
    Point fromPoint, Point toPoint) async {
  final res = await Requester().get('/delivery/search', params: {
    'from_point_id': fromPoint.id,
    'to_point_id': toPoint.id,
  });
  return List.castFrom(res.payload).map((e) => Delivery.fromJson(e)).toList();
}

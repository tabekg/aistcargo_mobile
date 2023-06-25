import 'package:aistcargo/models/point.dart';
import 'package:aistcargo/models/user.dart';
import 'package:intl/intl.dart';

enum DeliveryBodyTypeEnum {
  small,
  medium,
  large,
  truck,

  other,
}

enum DeliveryTypeEnum {
  airplane,
  car,
  truck,
}

enum DeliveryStatusEnum {
  pending,
  active,
  inactive,
}

class Delivery {
  Delivery({
    this.id,
    required this.fromPointId,
    required this.toPointId,
    this.description,
    this.createdAt,
    required this.dateTime,
    this.weight,
    this.bodyType,
    this.activationDatetime,
    this.deactivationDatetime,
    required this.type,
    this.status,
  });

  int? id;

  int fromPointId;
  int toPointId;
  String? description;

  Point? fromPoint;
  Point? toPoint;

  User? user;

  DateTime? createdAt;
  DateTime dateTime;
  int? weight;
  DeliveryBodyTypeEnum? bodyType;

  DateTime? activationDatetime;
  DateTime? deactivationDatetime;

  DeliveryTypeEnum type;
  DeliveryStatusEnum? status;

  String get typeTitle {
    if (type == DeliveryTypeEnum.airplane) {
      return 'самолетом';
    }
    if (type == DeliveryTypeEnum.car) {
      return 'автомобилем';
    }
    if (type == DeliveryTypeEnum.truck) {
      return 'грузовиком';
    }
    return 'неизвестно';
  }

  Delivery.fromJson(Map<String, dynamic> json)
      : fromPointId = json['from_point_id'],
        toPointId = json['to_point_id'],
        fromPoint = json['from_point'] != null
            ? Point.fromJson(json['from_point'])
            : null,
        toPoint =
            json['to_point'] != null ? Point.fromJson(json['to_point']) : null,
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        description = json['description'],
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        dateTime =
            DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz').parse(json['datetime']),
        weight = json['weight'],
        bodyType = json['body_type'] == 'SMALL'
            ? DeliveryBodyTypeEnum.small
            : json['body_type'] == 'MEDIUM'
                ? DeliveryBodyTypeEnum.medium
                : json['body_type'] == 'LARGE'
                    ? DeliveryBodyTypeEnum.large
                    : DeliveryBodyTypeEnum.truck,
        activationDatetime = json['activation_datetime'] == null
            ? null
            : DateTime.parse(json['activation_datetime']),
        deactivationDatetime = json['deactivation_datetime'] == null
            ? null
            : DateTime.parse(json['deactivation_datetime']),
        type = json['type'] == 'AIRPLANE'
            ? DeliveryTypeEnum.airplane
            : json['type'] == 'CAR'
                ? DeliveryTypeEnum.car
                : DeliveryTypeEnum.truck,
        status = json['status'] == 'PENDING'
            ? DeliveryStatusEnum.pending
            : json['status'] == 'ACTIVE'
                ? DeliveryStatusEnum.active
                : json['status'] == 'INACTIVE'
                    ? DeliveryStatusEnum.inactive
                    : null;
}

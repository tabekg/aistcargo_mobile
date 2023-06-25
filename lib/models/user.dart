class User {
  User({
    required this.providerUid,
    required this.phoneNumber,
  });

  int? id;
  String providerUid;
  String phoneNumber;

  User.fromJson(Map<String, dynamic> json)
      : providerUid = json['provider_uid'],
        id = json['id'],
        phoneNumber = json['phone_number'];
}

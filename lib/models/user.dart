class User {
  User({required this.providerUid});

  String providerUid;

  User.fromJson(Map<String, dynamic> json) : providerUid = json['provider_id'];
}

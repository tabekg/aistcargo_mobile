enum UserGenderEnum {
  male,
  female,
}

class User {
  User({
    required this.providerUid,
    required this.phoneNumber,
  });

  int? id;
  String providerUid;
  String phoneNumber;
  String? fullName;

  UserGenderEnum? gender;

  User.fromJson(Map<String, dynamic> json)
      : providerUid = json['provider_uid'],
        id = json['id'],
        phoneNumber = json['phone_number'],
        gender = json['gender'] == 'MALE'
            ? UserGenderEnum.male
            : json['gender'] == 'FEMALE'
                ? UserGenderEnum.female
                : null,
        fullName = json['full_name'];
}

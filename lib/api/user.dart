import 'package:aistcargo/utils/requester.dart';

import '../models/user.dart';

Future<User?> fetchCurrentUser() async {
  try {
    final resp = await Requester().get('/user');
    if (resp.status != 'success') {
      return null;
    }
    return User.fromJson(resp.payload);
  } catch (_) {
    return null;
  }
}

Future<User?> updateProfile({
  required String fullName,
  required UserGenderEnum gender,
}) async {
  try {
    final resp = await Requester().post('/user', body: {
      'full_name': fullName,
      'gender': gender.name,
    });
    if (resp.status != 'success') {
      return null;
    }
    return User.fromJson(resp.payload);
  } catch (_) {
    return null;
  }
}

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

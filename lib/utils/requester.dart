import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HttpResponse {
  dynamic payload = {};
  String status = 'success';
  int result = 0;
  int? statusCode;

  HttpResponse({
    required this.payload,
    required this.status,
    required this.result,
    this.statusCode,
  });

  factory HttpResponse.unknownErrorResponse() {
    return HttpResponse(payload: {}, status: 'network_error', result: -1);
  }
}

class Requester {
  static Requester? _instance;

  Requester._(this.dio, this.options);

  Dio dio;

  factory Requester() {
    if (_instance != null) {
      return _instance!;
    }
    return Requester._(
      Dio(
        BaseOptions(
          // baseUrl: 'http://192.168.43.59:5000',
          baseUrl: 'https://api.aistcargo.besoft.kg',
        ),
      ),
      Options(),
    );
  }

  Future<String?> getToken() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      return await auth.currentUser?.getIdToken();
    } catch (_) {
      return null;
    }
  }

  Options options;

  Future<HttpResponse> get(String path) async {
    String? token = await getToken();
    try {
      final response = await dio.request(
        '/v1$path',
        options: options.copyWith(
          method: 'GET',
          headers: <String, dynamic>{
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data == null
          ? HttpResponse.unknownErrorResponse()
          : HttpResponse(
              payload: response.data!['payload'],
              status: response.data!['status'],
              result: response.data!['result'],
            );
    } on DioError catch (_) {
      print(_.response);
      return HttpResponse.unknownErrorResponse();
    } catch (_) {
      print(_);
      return HttpResponse.unknownErrorResponse();
    }
  }

  Future<HttpResponse> post(
    String path, {
    Map<String, dynamic> params = const {},
    Map<String, String>? headers,
    Map<String, dynamic> body = const {},
  }) async {
    String? token = await getToken();
    try {
      final response = await dio.request(
        '/v1$path',
        options: options.copyWith(
          method: 'POST',
          headers: <String, dynamic>{
            if (token != null) 'Authorization': 'Bearer $token',
            ...(headers ?? {}),
          },
        ),
        data: body,
      );
      return response.data == null
          ? HttpResponse.unknownErrorResponse()
          : HttpResponse(
              payload: response.data!['payload'],
              status: response.data!['status'],
              result: response.data!['result'],
            );
    } on DioError catch (_) {
      print(_.response);
      return HttpResponse.unknownErrorResponse();
    } catch (_) {
      print(_);
      return HttpResponse.unknownErrorResponse();
    }
  }
}

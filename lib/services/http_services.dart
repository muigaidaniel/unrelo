import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class HttpService {
  Dio dio = Dio();

  Future<dynamic> post(Map body) async {
    try {
      var response = await dio.post('http://3.120.34.79:5000/predict',
          data: body,
          options: Options(headers: {'Content-Type': 'application/json'}));

      // log("Data: ${response.data}");
      // log("Code: ${response.statusCode}");
      dynamic res = jsonDecode(response.data);
      return res;
    } on DioError catch (e) {
      if (e.response != null) {
        log("Message:${e.message}");
        log("Response: ${e.response!.data}");
        log("Status code: ${e.response!.statusCode}");
        return e.response!;
      } else {
        log("Message:${e.message}");
        log("Response: ${e.response!.data}");
        log("Status code: ${e.response!.statusCode}");
        return e.response;
      }
    }
  }
}

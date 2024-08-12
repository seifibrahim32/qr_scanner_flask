import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MongoDBDataSource {
  static final _connectionConfig =
      BaseOptions(
          connectTimeout: Duration(seconds: 1000) ,
          receiveTimeout: Duration(seconds: 1000),
          headers: {'content-Type':'application/json'},
          baseUrl: "http://YOUR-IP-WIFI_ADDRESS:50162");
  static final _connection = Dio(_connectionConfig);

  Future<String> getVisitorsInfo(String? userId) async {
    String visitorsInfo;
    Response response = await _connection
        .get('/get_user_data', queryParameters: {"idofuser": userId});
    if (response.statusCode == 200) {
      visitorsInfo = response.data["attendance_status"].toString();
    } else {
      visitorsInfo = "";
    }
    return visitorsInfo;
  }
}

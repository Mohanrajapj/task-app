import 'dart:io';

import 'package:dio/dio.dart';

class ApiRepository {
  Future<dynamic> getUser() async {
    try {
      var dio = Dio();
      dio.options.headers[HttpHeaders.contentTypeHeader] = "application/json";
      var response = await dio.request(
        'https://crudcrud.com/api/d3fb9b9f67b84dc3b7770cb1263e2d0f/userList',
      );
      if (response.statusCode == 200) {
        return {
          'status': true,
          'message': 'success',
          'data': response.data[0]['users'],
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': e.toString(),
      };
    }
  }
}

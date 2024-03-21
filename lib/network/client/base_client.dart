import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class BaseClient {

  Future<dynamic> getMethod(String serviceUrl) async {
    var url = Uri.parse(serviceUrl);
    try {
      final response = await http.get(url);
      return _processResponse(response);
    } on SocketException {
      print('No Internet connection');
      return "{\"errorMessage\":\"No Internet connection\"}";
    } on TimeoutException {
      print('Api not responding');
      return "{\"errorMessage\":\"Api not responding\"}";
    } catch (e) {
      print('Unknown error ' + e.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      var responseJson = utf8.decode(response.bodyBytes);

      //var responseJson =response.body;
      print(responseJson);
      return responseJson;
    } else if (response.statusCode == 201) {
      var responseJson = utf8.decode(response.bodyBytes);

      print(responseJson);
      return responseJson;
    } else if (response.statusCode == 422) {
      var responseJson = utf8.decode(response.bodyBytes);

      print(responseJson);
      return responseJson;
    } else if (response.statusCode == 401) {
      var responseJson = utf8.decode(response.bodyBytes);

      print(responseJson);
      return responseJson;
    } else {
      return getHttpResponseMessage(response.statusCode);
    }
  }

  String getHttpResponseMessage(int statusCode) {
    switch (statusCode) {
      case 200:
        return 'Success';
      case 201:
        return 'Created';
      case 204:
        return 'No Content';
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 500:
        return 'Internal Server Error';
      default:
        return 'Unknown Error: The status code is $statusCode';
    }
  }
}

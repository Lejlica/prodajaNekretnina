import "package:flutter/material.dart";
import "package:prodajanekretnina_mobile_novi/models/problemi.dart";
import "package:prodajanekretnina_mobile_novi/providers/base_provider.dart";

import 'package:prodajanekretnina_mobile_novi/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_mobile_novi/providers/base_provider.dart';
import 'package:prodajanekretnina_mobile_novi/utils/util.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

/*class NekretninaAgentiProvider extends BaseProvider<NekretninaAgenti> {
  NekretninaAgentiProvider() : super("NekretninaAgenti");

  @override
  NekretninaAgenti fromJson(data) {
    // TODO: implement fromJson
    return NekretninaAgenti.fromJson(data);
  }
*/
class ProblemProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  String? _endpoint;

  HttpClient client = new HttpClient();
  IOClient? http;

  ProblemProvider() {
   _baseUrl = const String.fromEnvironment("baseUrl", defaultValue: "http://10.0.2.2:7189/");

   // _baseUrl = const String.fromEnvironment("baseUrl", defaultValue: "https://10.0.2.2:7125/");
    print("baseurl: $_baseUrl");

    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = _baseUrl! + "/";
    }

    _endpoint = "Problem";
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  void refreshData() {
    // Add your code to fetch the updated data here
    // For example, you can call your `get` method or similar to fetch the latest data.
    get().then((data) {
      // Notify listeners when data is updated
      notifyListeners();
    });
  }

  Future<List<T>> getById(int id, [dynamic additionalData]) async {
    var url = Uri.parse("$_baseUrl$_endpoint/$id");

    Map<String, String> headers = createHeaders();

    var response = await http!.get(url, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return data.map((x) => fromJson(x)).cast<T>().toList();
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<List<T>> get([dynamic search]) async {
    var url = "$_baseUrl$_endpoint";

    if (search != null) {
      String queryString = getQueryString(search);
      url = url + "?" + queryString;
    }

    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();
    print("get me");
    var response = await http!.get(uri, headers: headers);
    print("done $response");
    print("Request URL uu: ${url}");
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return data['result'].map((x) => fromJson(x)).cast<T>().toList();
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<T?> insert(dynamic request) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http!.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data) as T;
    } else {
      return null;
    }
  }

  Future<T?> delete(int id, [dynamic request]) async {
    var url =
        "$_baseUrl$_endpoint/$id"; // Assuming you need to include an ID in the URL
    var uri = Uri.parse(url);
    Map<String, String> headers = createHeaders();

    var response =
        await http!.delete(uri, headers: headers, body: jsonEncode(request));

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data) as T;
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<T?> update(int id, [dynamic request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

    var response =
        await http!.put(uri, headers: headers, body: jsonEncode(request));

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data) as T;
    } else {
      return null;
    }
  }

  Map<String, String> createHeaders() {
    String? username = Authorization.username;
    String? password = Authorization.password;

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth,
      "App-Type": "Mobile"
    };
    return headers;
  }

  Problem fromJson(data) {
    // TODO: implement fromJson
    return Problem.fromJson(data);
  }
  /* T fromJson(data) {
    throw Exception("Override method");
  }*/

  String getQueryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        if (key is int) {
          key = '[$key]';
        } else if (value is List || value is Map) {
          key = '.$key';
        } else {
          key = '.$key';
        }
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = value;
        if (value is String) {
          encoded = Uri.encodeComponent(value);
        }
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value as DateTime).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }

  bool isValidResponseCode(Response response) {
    if (response.statusCode == 200) {
      if (response.body != "") {
        return true;
      } else {
        return false;
      }
    } else if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 400) {
      throw Exception("Bad request");
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (response.statusCode == 403) {
      throw Exception("Forbidden");
    } else if (response.statusCode == 404) {
      throw Exception("Not found");
    } else if (response.statusCode == 500) {
      throw Exception("Internal server error");
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }
}

import 'dart:convert';
import "dart:io";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:http/http.dart";
import "package:prodajanekretnina_admin/models/emailModel.dart";
import "package:prodajanekretnina_admin/models/kategorijeNekretnina.dart";
import "package:prodajanekretnina_admin/models/search_result.dart";
import "package:prodajanekretnina_admin/utils/util.dart";

abstract class BaseProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  String _endpoint = "";

  BaseProvider(String endpoint) {
    _endpoint = endpoint;
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:7189/");
  }

  Future<SearchResult<T>> get({dynamic filter}) async {
    var url = "$_baseUrl$_endpoint";

    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      var result = SearchResult<T>();

      result.count = data['count'];

      for (var item in data['result']) {
        result.result.add(fromJson(item));
      }

      return result;
    } else {
      throw Exception("Unknown error");
    }
    // print("response: ${response.request} ${response.statusCode}, ${response.body}");
  }

  Future<T?> delete(int id, [dynamic request]) async {
    var url =
        "$_baseUrl$_endpoint/$id"; // Assuming you need to include an ID in the URL
    var uri = Uri.parse(url);
    Map<String, String> headers = createHeaders();

    var response =
        await http.delete(uri, headers: headers, body: jsonEncode(request));

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<bool> updatePassword(int userId, String newPassword,
      Map<String, dynamic> additionalData) async {
    try {
      var url = "$_baseUrl$_endpoint/$userId/update-password";
      var uri = Uri.parse(url);

      Map<String, String> headers = createHeaders();
      Map<String, dynamic> request = {
        'newPassword': newPassword,
        ...additionalData, // Dodajte dodatne informacije o korisniku
      };

      print("RequestK: $request"); // Dodajte ovu liniju za praćenje
      var response =
          await http.put(uri, headers: headers, body: jsonEncode(request));

      print("ResponseK: ${response.body}"); // Dodajte ovu liniju za praćenje

      if (isValidResponse(response)) {
        return true; // Ažuriranje uspješno
      } else {
        return false; // Ažuriranje nije uspješno
      }
    } catch (error) {
      print("ErrorK: $error"); // Dodajte ovu liniju za praćenje
      return false; // Greška prilikom ažuriranja lozinke
    }
  }

  Future<T> insert(dynamic request) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<T> update(int id, [dynamic request]) async {
    try {
      var url = "$_baseUrl$_endpoint/$id";
      var uri = Uri.parse(url);
      var headers = createHeaders();

      var jsonRequest = jsonEncode(request);
      var response = await http.put(uri, headers: headers, body: jsonRequest);

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        return fromJson(data);
      } else {
        throw Exception('Invalid response from server: ${response.body}');
      }
    } catch (e) {
      print('Error during update: $e');
      rethrow; // Ponovno bacanje izuzetka kako bi se mogao uhvatiti na višem nivou
    }
  }

  T fromJson(data) {
    throw Exception("Method not implemented");
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      print(response.body);
      throw Exception("Something bad happened please try again");
    }
  }

  Map<String, String> createHeaders() {
    String username = Authorization.username ?? "";
    String password = Authorization.password ?? "";

    print("passed creds: $username, $password");

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };

    return headers;
  }

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
        query += '$prefix$key=${(value).toIso8601String()}';
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
   Future<void> sendConfirmationEmail(EmailModel emailModel) async {
  final url = '$_baseUrl/Nekretnine/SendConfirmationEmail';
  final response = await http.post(
    Uri.parse(url),
    headers: createHeaders(),
    body: jsonEncode(emailModel.toJson()),
  );

  if (response.statusCode != 200) {
    throw Exception('Greška prilikom slanja emaila');
  }
}

}

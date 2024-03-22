import 'dart:convert';

import 'package:app_movie/services/api_url.dart';
import 'package:http/http.dart' as http;

class UserApi {
static Future<http.Response> signUpUser(Map data) async {
    final url = ApiUrl.signUpUser;
    final uri = Uri.parse(url);

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    final response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: headers
    );

    return response;
  }

  static Future<http.Response> signInUser(Map data) async {
    final url = ApiUrl.signInUser;
    final uri = Uri.parse(url);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    final response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: headers
    );

    return response;
  }

  static Future<bool> verifyEmail(String email) async {
    final url = '${ApiUrl.verifyEmail}$email';
    final uri = Uri.parse(url);
    final response = await http.post(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if(json['status'] == 'found') return true;
      return false;
    }
    return false;
  }

  static Future<bool> changePass(Map<String, dynamic> data) async {
    final url = ApiUrl.changePass;

    final uri = Uri.parse(url);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.put(uri, body: jsonEncode(data), headers: headers);

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if(json['status'] == 'success') return true;
      return false;
    }
    return false;
  }

  static Future<bool> signInWithGoogle() async {
    final url = ApiUrl.signInWithGoogle;
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    return response.statusCode == 200;
  }

  static Future<http.Response> updateUser(Map<String, String> data) async {
    final url = ApiUrl.updateUser;
    final uri = Uri.parse(url);

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode(data);
    final response = await http.post(
      uri,
      headers: headers,
      body: body
    );
    return response;
  }

  static Future<bool> checkEmailUpdate(Map<String, String> data) async {
    final url = ApiUrl.checkEmailUpdate;
    final uri = Uri.parse(url);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode(data);
    final response = await http.post(
      uri,
      headers: headers,
      body: body
    );

    if(response.statusCode == 200) {
      return jsonDecode(response.body)['status'] == '1';
    }
    return false;
  }

  static Future<http.Response> sendGoogleSignInDataToApi(Map<String, dynamic> body) async {
    final apiUrl = ApiUrl.sendGoogleSignInDataToApi;
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(body)
    );

    return response;
  }
}
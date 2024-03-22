import 'dart:convert';

import 'package:app_movie/services/api_url.dart';
import 'package:http/http.dart' as http;

class ComBoApi {
  static Future<List<dynamic>> getCombos() async {
    final url = ApiUrl.getCombos;
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    dynamic test = jsonDecode(response.body);
    if(response.statusCode == 200) {
      return test['combos'];
    }
    return [];
  }
}
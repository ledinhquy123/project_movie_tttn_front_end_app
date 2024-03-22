import 'dart:convert';

import 'package:app_movie/services/movies_api.dart';

class ActorController {
  static Future<List<dynamic>> getActor(String id) async {
    final response = await MovieApi.getActors(id);
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return [];
  }
}
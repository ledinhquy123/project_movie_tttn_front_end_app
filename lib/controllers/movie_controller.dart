import 'dart:convert';

import 'package:app_movie/services/movies_api.dart';

class MovieController {
  static Future<Map<String, dynamic>> getShowtime(String weekdayId) async {
   final response = await MovieApi.getShowtime(weekdayId);
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return {};
  } 

  static Future<List<dynamic>> getMovieTrending() async {
    final response = await MovieApi.getMovieTrending();
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return List<dynamic>.empty();
  }

  static Future<List<dynamic>> getMoviePopular() async {
    final response = await MovieApi.getMoviePopular();
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return List<dynamic>.empty();
  }

  static Future<List<dynamic>> getMovieNowPlaying() async {
    final response = await MovieApi.getMovieNowPlaying();
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return List<dynamic>.empty();
  }

  static Future<List<dynamic>> getMovieUpComing() async {
    final response = await MovieApi.getMovieUpComing();
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return List<dynamic>.empty();
  }

  static Future<List<dynamic>> getMovieName() async {
    final response = await MovieApi.getMovieName();
    if(response.statusCode == 200) {
      // print(jsonDecode(response.body));
      return jsonDecode(response.body) as List<dynamic>;
    }
    return [];
  }

  static Future<List<dynamic>> getWeekday() async {
    final response = await MovieApi.getWeekday();
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return [];
  }

  static Future<List<dynamic>> getShowtimeMovieWeekday(String weekdayId, String movieId) async {
    final response = await MovieApi.getShowtimeMovieWeekday(weekdayId, movieId);
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return [];
  }
}
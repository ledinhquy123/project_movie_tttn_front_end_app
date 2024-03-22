import 'dart:convert';

import 'package:app_movie/services/api_url.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  static Future<http.Response> getMovieTrending() async {
    final url = ApiUrl.getMovieTrending;

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    return response;
  }

  static Future<http.Response> getMoviePopular() async {
    final url = ApiUrl.getMoviePopular;
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    return response;
  }

  static Future<http.Response> getMovieNowPlaying() async {
    final url = ApiUrl.getMovieNowPlaying;
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    return response;
  }

  static Future<http.Response> getMovieUpComing() async {
    final url = ApiUrl.getMovieUpComing;
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    return response;
  }

  static Future<http.Response> getMovieName() async {
    final url = ApiUrl.getMovieName;
    final uri = Uri.parse(url);

    final response = await http.get(uri);
    return response;
  }

  static Future<http.Response> getActors(String id) async {
    final url = '${ApiUrl.getActors}$id';
    print(url);
    final uri = Uri.parse(url);

    final response = await http.get(uri);
    return response;
  }

  static Future<http.Response> getWeekday() async {
    final url = ApiUrl.getWeekday;
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    return response;
  }

  static Future<http.Response> getShowtime(String weekdayId) async {
    final url = '${ApiUrl.getShowtime}$weekdayId';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    return response;
  }

  static Future<http.Response> getShowtimeMovieWeekday(String weekdayId, String movieId) async {
    final url = '${ApiUrl.getShowtimeMovieWeekday}$weekdayId/$movieId';
    final uri = Uri.parse(url);

    final response = await http.get(uri);
    return response;
  }

  static Future<http.Response> getSeats(String screenId, String showtimeId) async {
    // print(showtimeId);
    final url = '${ApiUrl.getSeats}$screenId/$showtimeId';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    // print(response.statusCode);
    return response; 
  }

  static Future<http.Response> reservations(Map<String, dynamic> data) async {
    final url = ApiUrl.reservations;
    final uri = Uri.parse(url);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    return await http.post(
      uri,
      body: jsonEncode(data),
      headers: headers
    );
  }

  static Future<http.Response> getBill(Map<String, dynamic> data) async {
    final url = ApiUrl.getBill;
    final uri = Uri.parse(url);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    return await http.post(
      uri,
      body: jsonEncode(data),
      headers: headers
    );
  }

  static Future<List<dynamic>> getMovieComments(String idMovie) async {
    final url = '${ApiUrl.getMovieComments}$idMovie';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      final result = jsonDecode(response.body)['comments'];
      print(result);
      return result;
    }
    return [];
  }

  static Future<bool> createMovieComment(Map<String, dynamic> body) async {
    final url = ApiUrl.createMovieComment;
    final uri = Uri.parse(url);

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body)
    );
    if(response.statusCode == 200) {
      final result = jsonDecode(response.body)['create-comment'];
      return result == '1';
    }
    return false;
  }

  static Future<bool> checkUserComment(Map<String, dynamic> body) async {
    final url = ApiUrl.checkUserComment;
    final uri = Uri.parse(url);

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body)
    );
    print(response.statusCode);
    if(response.statusCode == 200) {
      final result = jsonDecode(response.body)['check'];
      print('ok $result');
      return result == '1';
    }
    return false;
  }
}
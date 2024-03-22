import 'package:app_movie/services/movies_api.dart';

class CommentController {
  static Future<bool> createMovieComment(Map<String, dynamic> body) async {
    final response = await MovieApi.createMovieComment(body);
    if(response) {
      return true;
    }else {
      return false;
    }
  }
}
import 'dart:convert';

import 'package:app_movie/services/movies_api.dart';
import 'package:app_movie/services/transaction_api.dart';

class TransactionController {
  static Future<List<dynamic>> getTicket(String userId) async {
    final response = await TransactionApi.getTicket(userId);
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      if(data != null) return data;
      return [];
    }
    return [];
  }

  static Future<List<dynamic>> getAllTickets() async {
    final response = await TransactionApi.getAllTickets();
    if(response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return [];
  }

  static Future<void> createTicket(dynamic body) async {
    print(body);
    await TransactionApi.createTicket(body);
  }

  static Future<bool> reservations(Map<String, dynamic> data) async {
    final response = await MovieApi.reservations(data);
    return response.statusCode == 200;
  }

  static Future<List<dynamic>> getTransactions() async {
    final response = await TransactionApi.getTransactions();
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return [];
  }

  static Future<List<dynamic>> getBill(Map<String, dynamic> data) async {
    final response = await MovieApi.getBill(data);
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return [];
  }

  static Future<List<dynamic>> getSeats(String screenId, String showtimeId) async {
    final response = await MovieApi.getSeats(screenId, showtimeId);
    // print(response.statusCode);
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return [];
  }
}
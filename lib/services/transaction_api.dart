import 'dart:convert';

import 'package:app_movie/services/api_url.dart';
import 'package:http/http.dart' as http;

class TransactionApi {
  static Future<http.Response> getTransactions() async {
    final url = ApiUrl.getTransactions;
    final uri = Uri.parse(url);

    return await http.get(uri);
  }

  static Future<void> createTicket(Map<String, dynamic> body) async {
    final url = ApiUrl.createTicket;
    final uri = Uri.parse(url);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body)
    );
  }

  static Future<http.Response> getAllTickets() async {
    final url = ApiUrl.getAllTickets;
    final uri = Uri.parse(url);
    return await http.get(uri);
  }

  static Future<http.Response> getTicket(String userId) async {
    final url = '${ApiUrl.getTicket}$userId';
    final uri = Uri.parse(url);
    return await http.get(uri);
  }
} 
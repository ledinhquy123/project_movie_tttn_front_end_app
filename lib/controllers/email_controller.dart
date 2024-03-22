import 'package:app_movie/services/users_api.dart';
import 'package:app_movie/utils/show_snackbar.dart';
import 'package:email_sender/email_sender.dart';
import 'package:flutter/material.dart';

class EmailController {
  static Future<void> sendEmail(BuildContext context, String email, int randomNumber) async {
    try {
      EmailSender emailSender = EmailSender();
      await emailSender.sendOtp(email, randomNumber);
      // ignore: use_build_context_synchronously
      showSnackbar(context, 'Mã gửi về email của bạn', Colors.green);
    } catch (error) {
      print('Error: $error');
    }
  }

  static Future<bool> verifyEmail(BuildContext context, String email) async {
    final check = await UserApi.verifyEmail(email);
    return check;
  }
}
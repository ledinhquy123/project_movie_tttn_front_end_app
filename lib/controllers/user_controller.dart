import 'dart:convert';

import 'package:app_movie/services/users_api.dart';
import 'package:app_movie/utils/show_dialog.dart';
import 'package:app_movie/utils/show_snackbar.dart';
import 'package:app_movie/views/screens/home_screen.dart';
import 'package:app_movie/views/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController {
  static Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      await _googleSignIn.signIn();
      final GoogleSignInAccount? googleUser = _googleSignIn.currentUser;
      if (googleUser == null) {
        print('Đăng nhập không thành công');
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

       // Gửi thông tin đăng nhập lên Laravel API
      if(googleUser.toString() != '' && googleAuth.accessToken != null) {
        String photoUrl = 'https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg';
        if(googleUser.photoUrl != null) {
          photoUrl = googleUser.photoUrl!;
        } 
        // ignore: use_build_context_synchronously
        await sendGoogleSignInDataToApi(
          googleAuth.accessToken!,
          googleUser.id,
          googleUser.displayName!,
          googleUser.email,
          photoUrl,
          context
        );
      } else {
        print('Không thành công');
        return;
      }
    } catch (error) {
      print('Sao lại lỗi :))): $error');
    }
  }


  static Future<void> sendGoogleSignInDataToApi(
    String accessToken, 
    String id,
    String name,
    String email, 
    String avatar,
    BuildContext context
  ) async {
    final body = {
      'access_token': accessToken,
      'provider_id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
    };
    final response = await UserApi.sendGoogleSignInDataToApi(body);

    if (response.statusCode == 200) {
      // Xử lý phản hồi từ Laravel API (nếu cần)
      // print(jsonDecode(response.body));
      final json = jsonDecode(response.body);
      if(json['user'] != null) {
        SignInScreen.user = json['user'];
        // ignore: use_build_context_synchronously
        showSnackbar(context, 'Đăng nhập thành công', Colors.green);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const HomeScreen())
        );
      }else {
        // ignore: use_build_context_synchronously
        showSnackbar(context, 'Đăng nhập thất bại', Colors.red);
      }
    } else {
      print('Failed to send Google Sign-In data. Error code: ${response.statusCode}');
    }
  }

  static Future<bool> logInUser(String email, String password, BuildContext context) async {
    final body = {
      'email': email,
      'password': password
    };

    final response = await UserApi.signInUser(body);

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if(json['status'] != ''){
        if(json['status'] == 1) {
          SignInScreen.user = json['user'];

          return true;
        }else {
          // ignore: use_build_context_synchronously
          showSnackbar(context, 'Mật khẩu chưa chính xác', Colors.red);
          return false;
        }
      }else {
        // ignore: use_build_context_synchronously
        showSnackbar(context, 'Email hoặc mật khẩu không hợp lệ', Colors.red);
        return false;
      }
    }
    return false;
  }

  static Future<void> signOutGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signOut();
      print('User signed out from Google');
    } catch (error) {
      print('Error signing out from Google: $error');
    }
  }

  static Future<void> changePass(BuildContext context, String email, String password) async {
    final body = {
      'email': email,
      'password': password
    };
    bool response = await UserApi.changePass(body);
    print(response);
    if(response) {
      // ignore: use_build_context_synchronously
      openDialog(
        context, 
        'Thành công', 
        'Tài khoản của bạn đã được đổi mật khẩu thành công'
      );
    }else {
      // ignore: use_build_context_synchronously
      showSnackbar(context, 'Đổi mật khẩu thất bại', Colors.red);
    }
  }

  static Future<bool> checkEmailUpdate(BuildContext context, Map<String, String> data) async {
    final check = await UserApi.checkEmailUpdate(data);
    if(check) {
      await updateUser(data);
      return true;
    }
    return false;
  }
  
  static Future<void> updateUser(Map<String, String> data) async {
    final response = await UserApi.updateUser(data);
    if(response.statusCode == 200) {
      SignInScreen.user = jsonDecode(response.body)['user'];
    }
  }

  static Future<bool> signUpUser(BuildContext context, String name, String email, String password) async {
    final body = {
      'name': name,
      'email': email,
      'password': password
    };
    final response = await UserApi.signUpUser(body);
    print(response.body);

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if(json['message'] != 'Đăng kí thành công') {
        // ignore: use_build_context_synchronously
        showSnackbar(context, json['message'], Colors.red);
        return false;
      }else {
        return true;
      }
    }else {
      // ignore: use_build_context_synchronously
      showSnackbar(context, 'Đăng kí thất bại', Colors.red);
      return false;
    }
  }
}
import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/views/screens/sign_in_screen.dart';
import 'package:app_movie/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            child: Image.asset(
              'assets/images/get_started.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 5,
              bottom: MediaQuery.of(context).size.height / 10
            ),
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            decoration: BoxDecoration(
              color: secondaryMain.withOpacity(.76)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/logo.png'),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 20,
                  child: CustomButton(
                    text: 'BẮT ĐẦU',
                    onTap: () => Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const SignInScreen())
                    ),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 16
                    )
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
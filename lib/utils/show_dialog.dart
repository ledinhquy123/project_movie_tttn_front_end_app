import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/views/screens/sign_in_screen.dart';
import 'package:app_movie/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';

void openDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32)
      ),
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        padding: const EdgeInsets.all(24),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(32)
          ),
          color: outline
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/charm_circle_tick.png'),
            const SizedBox(height: 16),

            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: navigtorBar1.withOpacity(.79),
              ),
            ),
            const SizedBox(height: 8),

            Text(
              content,
              softWrap: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: navigtorBar1.withOpacity(.79),
              ),
            ),
            const SizedBox(height: 16),

            CustomButton(
              text: 'ok',
              style: const TextStyle(color: Colors.white),
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const SignInScreen())
                );
              },
            )
          ],
        ),
      ),
    )
  );
}
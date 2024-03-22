import 'package:app_movie/views/screens/seats_screen.dart';
import 'package:flutter/material.dart';

Widget customShowTime(dynamic e, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => SeatScreen(
            movie: e,
          )
        )
      );
    },
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ 
            const Color(0xFFD7F3F6).withOpacity(.6), 
            const Color(0xFFF2F2F2)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            e['start_time'],
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
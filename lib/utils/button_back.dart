import 'package:flutter/material.dart';

Widget showButtonBack(BuildContext context, Color color1, Color color2, IconData icon, double top, double left) {
  return Positioned(
    top: top,
    left: left,
    child: InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ color1, color2 ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(40)
          )
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    ),
  );
}
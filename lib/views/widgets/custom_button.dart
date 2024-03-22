import 'package:app_movie/constant/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  String? text;
  void Function()? onTap;
  TextStyle? style;

  CustomButton({
    super.key,
    this.text,
    this.onTap,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [ button1, button2 ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: const BorderRadiusDirectional.all(
            Radius.circular(16)
          ),
          border: Border.all(
            width: 1,
            color: outline
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(2, 1),
              color: button1
            )
          ]
        ),
        child: Text(
          text!,
          textAlign: TextAlign.center,
          style: style
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  bool obscureText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  String? Function(String?)? validator;
  String? hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextStyle? hintStyle;
  bool? filled;
  Color? fillColor;
  InputBorder? enabledBorder;
  InputBorder? focusedBorder;
  TextStyle? style;
  void Function(String)? onChanged;
  InputBorder? errorBorder;
  TextStyle? errorStyle;
  InputBorder? focusedErrorBorder;
  void Function()? onEditingComplete;
  bool? enabled;
  InputBorder? disabledBorder;
  int? maxLines;
  EdgeInsetsGeometry? contentPadding;

  CustomTextFormField({
    super.key,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.validator,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.filled,
    this.fillColor,
    this.enabledBorder,
    this.focusedBorder,
    this.style,
    this.onChanged,
    this.errorBorder,
    this.errorStyle,
    this.focusedErrorBorder,
    this.onEditingComplete,
    this.enabled = true,
    this.disabledBorder,
    this.maxLines = 1,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 4),
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      style: style,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        contentPadding: contentPadding,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: filled,
        fillColor: fillColor,
        enabledBorder: enabledBorder,
        disabledBorder: disabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        errorStyle: errorStyle,
        focusedErrorBorder: focusedErrorBorder
      ),
    );
  }
}
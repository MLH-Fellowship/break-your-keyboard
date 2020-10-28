import 'package:flutter/material.dart';

import '../colors.dart';

class TextFieldOutlined extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool capitalized;

  final int maxLength;
  const TextFieldOutlined(
      {Key key,
      this.controller,
      this.hintText,
      this.capitalized = false,
      this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      style: const TextStyle(fontSize: 18),
      textCapitalization:
          capitalized ? TextCapitalization.characters : TextCapitalization.none,
      decoration: InputDecoration(
        fillColor: AppColors.blackColor.withOpacity(0.4),
        counterText: '',
        filled: true,
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.skyBlueColor, width: 5.0),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.skyBlueColor, width: 3.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.skyBlueColor, width: 3.0),
        ),
      ),
    );
  }
}

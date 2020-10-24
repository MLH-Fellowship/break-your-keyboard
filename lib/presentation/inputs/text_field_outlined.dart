import 'package:flutter/material.dart';

import '../colors.dart';

class TextFieldOutlined extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const TextFieldOutlined({Key key, this.controller, this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 18),
      decoration: InputDecoration(
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

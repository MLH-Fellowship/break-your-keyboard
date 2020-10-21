import 'dart:async';

import 'package:flutter/material.dart';

import '../colors.dart';
import '../fonts.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final String hintText;
  final String hintLabel;
  final TextInputType textInputType;
  final String initialValue;
  final TextInputAction inputAction;
  final StreamController textChangeListener;
  final Function(String) onSubmitTap;
  final int maxLines;
  final int minLines;
  final Function(String) onTextChange;
  final TextStyle labelTextStyle;

  const TextFieldWidget(
      {this.label = '',
      this.hintLabel = '',
      this.initialValue,
      this.hintText,
      this.textInputType = TextInputType.text,
      @required this.textChangeListener,
      this.maxLines = 1,
      this.minLines = 1,
      Key key,
      this.inputAction = TextInputAction.done,
      this.onSubmitTap,
      this.onTextChange,
      this.labelTextStyle = const TextStyle(
          color: AppColors.blackColor,
          fontFamily: AppFonts.cabin,
          fontSize: 13,
          fontWeight: FontWeight.w500)})
      : super(key: key);

  @override
  _WidgetState createState() => _WidgetState();
}

class _WidgetState extends State<TextFieldWidget> {
  TextEditingController _textController;

  static const double _borderRadius = 10;

  @override
  void initState() {
    _textController = TextEditingController();
    _textController.text = widget.initialValue;
    _textController.addListener(() {
      if (widget.textChangeListener != null) {
        widget.textChangeListener.add(_textController.text);
      }

      if (widget.onTextChange != null) {
        widget.onTextChange(_textController.text);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color activeColor = AppColors.skyBlueColor;

    Color color;

    const Color borderColor = activeColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label ?? '',
              style: widget.labelTextStyle,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    widget.hintLabel ?? '',
                    style: TextStyle(
                        color: AppColors.whiteColorOpacity50, fontSize: 11),
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextFormField(
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              textInputAction: widget.inputAction,
              onFieldSubmitted: widget.onSubmitTap,
              controller: _textController,
              keyboardType: widget.textInputType,
              style: const TextStyle(color: AppColors.whiteColor, fontSize: 13),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(color: AppColors.whiteColorOpacity50),
                contentPadding: EdgeInsets.only(
                    left: 22, right: 24, top: widget.maxLines > 1 ? 24 : 0),
                focusColor: color,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: borderColor),
                  borderRadius: BorderRadius.circular(_borderRadius),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: borderColor),
                  borderRadius: BorderRadius.circular(_borderRadius),
                ),
              ),
            ),
            const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

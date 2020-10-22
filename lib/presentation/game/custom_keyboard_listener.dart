import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomKeyboardListener extends StatefulWidget {
  final Widget child;
  final Function onAction;

  const CustomKeyboardListener(
      {@required this.child, @required this.onAction, Key key})
      : super(key: key);

  @override
  _CustomKeyboardListenerState createState() => _CustomKeyboardListenerState();
}

class _CustomKeyboardListenerState extends State<CustomKeyboardListener> {
  FocusNode focusNode = FocusNode();
  bool _hasPressedSpaceDown = false;
  bool _hasPressedOtherKeyDown = false;

  void _toggleHasPressedSpaceDown() {
    setState(() {
      _hasPressedSpaceDown = !_hasPressedSpaceDown;
    });
  }

  void _toggleHasPressedOtherKeyDown() {
    setState(() {
      _hasPressedOtherKeyDown = !_hasPressedOtherKeyDown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: focusNode,
      onKey: (RawKeyEvent event) {
        final hasPressedSpace =
            event.data.logicalKey == LogicalKeyboardKey.space;
        if (hasPressedSpace && event is RawKeyUpEvent) {
          widget.onAction();
          _toggleHasPressedSpaceDown();
        } else if (hasPressedSpace && event is RawKeyDownEvent) {
          _toggleHasPressedSpaceDown();
        } else {
          _toggleHasPressedOtherKeyDown();
        }
      },
      child: widget.child,
    );
  }
}

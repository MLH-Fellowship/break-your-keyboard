import 'package:flutter/material.dart';

import '../../../presentation/colors.dart';

class GameTimeSelector extends StatefulWidget {
  final Function(String value) onChanged;
  const GameTimeSelector({
    Key key,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _GameTimeSelectorState createState() => _GameTimeSelectorState();
}

class _GameTimeSelectorState extends State<GameTimeSelector> {
  final deviceTypes = ['10 sec', '15 sec', '30 sec'];
  String currentSelectedValue;
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            fillColor: Colors.black.withOpacity(0.4),
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.skyBlueColor, width: 3.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.skyBlueColor, width: 3.0),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: const Text('Game Time'),
              style: const TextStyle(fontSize: 18),
              value: currentSelectedValue,
              isDense: true,
              onChanged: (newValue) {
                setState(() {
                  currentSelectedValue = newValue;
                });
                widget.onChanged(newValue);
              },
              items: deviceTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

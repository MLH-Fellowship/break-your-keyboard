import 'package:flutter/material.dart';

class TrafficLight extends StatelessWidget {
  final TrafficColor activeLight;

  const TrafficLight({
    Key key,
    this.activeLight = TrafficColor.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color:
                        Colors.red.withOpacity(activeLight != null ? 1 : 0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.yellow
                        .withOpacity(activeLight != TrafficColor.red ? 1 : 0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.green
                        .withOpacity(activeLight == TrafficColor.green ? 1 : 0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

enum TrafficColor{red, yellow, green}
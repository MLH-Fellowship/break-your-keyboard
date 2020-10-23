import 'package:flutter/material.dart';

class TrafficLight extends StatelessWidget {
  final int activeLightIndex;

  const TrafficLight({
    Key key,
    this.activeLightIndex = 0,
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
                        Colors.red.withOpacity(activeLightIndex > 0 ? 1 : 0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.yellow
                        .withOpacity(activeLightIndex > 1 ? 1 : 0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.green
                        .withOpacity(activeLightIndex > 2 ? 1 : 0.2),
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

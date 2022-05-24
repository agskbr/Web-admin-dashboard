import 'package:flutter/material.dart';

class NotificationIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Icon(
            Icons.notifications_none_outlined,
            color: Colors.grey,
          ),
          Positioned(
            left: 3,
            child: Container(
              width: 5,
              height: 5,
              decoration: buildBoxDecoration(),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(100),
      );
}

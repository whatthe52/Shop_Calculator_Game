// single_item_container.dart
import 'package:flutter/material.dart';

class SingleItemContainer extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  final String? imagePath;
  final VoidCallback onTap;

  SingleItemContainer({
    required this.color,
    required this.text,
    required this.value,
    this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: color,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Image.asset(
                imagePath!,
                width: 50,
                height: 50,
              ),
            Text(
              '$text: $value',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

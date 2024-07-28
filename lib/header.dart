import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Text(
        '\nCalculate any items',
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

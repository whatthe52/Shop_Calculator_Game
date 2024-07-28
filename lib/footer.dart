import 'package:flutter/material.dart';

class IndependentButtons extends StatelessWidget {
  final Function(int) onButtonPressed;
  final VoidCallback onEnterPressed;
  final VoidCallback onBackPressed;

  const IndependentButtons({
    required this.onButtonPressed,
    required this.onEnterPressed,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 175, // Set a fixed height or adjust as needed
      color: Color.fromRGBO(41, 47, 58, 1.000),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonRow(
            onButtonPressed: onButtonPressed,
            onEnterPressed: onEnterPressed, // Pass the onEnterPressed callback
          ),
          ButtonRow2(
            onButtonPressed: onButtonPressed,
            onBackPressed: onBackPressed, // Pass the onBackPressed callback
          ),
        ],
      ),
    );
  }
}

class ButtonRow extends StatelessWidget {
  final Function(int) onButtonPressed;
  final VoidCallback onEnterPressed;

  ButtonRow({
    required this.onButtonPressed,
    required this.onEnterPressed, // Add onEnterPressed as a required parameter
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ButtonWithImageBackground(
            onPressed: () => onButtonPressed(1),
            text: '1',
            imagePath: 'assets/footerbtn/nobtn.png',
          ),
        ),
        Expanded(
          child: ButtonWithImageBackground(
            onPressed: () => onButtonPressed(2),
            text: '2',
            imagePath: 'assets/footerbtn/nobtn.png',
          ),
        ),
        Expanded(
          child: ButtonWithImageBackground(
            onPressed: () => onButtonPressed(3),
            text: '3',
            imagePath: 'assets/footerbtn/nobtn.png',
          ),
        ),
        Expanded(
          child: ButtonWithImageBackground(
            onPressed: () => onButtonPressed(4),
            text: '4',
            imagePath: 'assets/footerbtn/nobtn.png',
          ),
        ),
        Expanded(
          child: ButtonWithImageBackground(
            onPressed: () => onButtonPressed(5),
            text: '5',
            imagePath: 'assets/footerbtn/nobtn.png',
          ),
        ),
        ButtonWithImageBackground(
          onPressed: onEnterPressed, // Use the onEnterPressed callback
          text: '',
          imagePath: 'assets/footerbtn/enterbtn.png',
        ),
      ],
    );
  }
}

class ButtonRow2 extends StatelessWidget {
  final Function(int) onButtonPressed;
  final VoidCallback onBackPressed;

  ButtonRow2({
    required this.onButtonPressed,
    required this.onBackPressed, // Add onBackPressed as a required parameter
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ButtonWithImageBackground(
            onPressed: () => onButtonPressed(6),
            text: '6',
            imagePath: 'assets/footerbtn/nobtn.png',
          ),
        ),
        Expanded(
          child: ButtonWithImageBackground(
            onPressed: () => onButtonPressed(7),
            text: '7',
            imagePath: 'assets/footerbtn/nobtn.png',
          ),
        ),
        Expanded(
          child: ButtonWithImageBackground(
            onPressed: () => onButtonPressed(8),
            text: '8',
            imagePath: 'assets/footerbtn/nobtn.png',
          ),
        ),
        Expanded(
          child: ButtonWithImageBackground(
            onPressed: () => onButtonPressed(9),
            text: '9',
            imagePath: 'assets/footerbtn/nobtn.png',
          ),
        ),
        Expanded(
          child: ButtonWithImageBackground(
            onPressed: () => onButtonPressed(0),
            text: '0',
            imagePath: 'assets/footerbtn/nobtn.png',
          ),
        ),
        ButtonWithImageBackground(
          onPressed: onBackPressed, // Use the onBackPressed callback
          text: '',
          imagePath: 'assets/footerbtn/backbtn.png',
        ),
      ],
    );
  }
}

class ButtonWithImageBackground extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String imagePath;

  ButtonWithImageBackground({
    required this.onPressed,
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath), // Path to your image
          fit: BoxFit
              .contain, // Ensures the entire image is visible within the container
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.all(14.5),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Teko',
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

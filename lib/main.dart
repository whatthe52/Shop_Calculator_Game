import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'navbar.dart';
import 'footer.dart';
import 'header.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int item1 = 0;
  String? item1ImagePath;
  int item2 = 0;
  String? item2ImagePath;
  String operation = '';
  int result = 0;
  bool isEditingItem1 = true; // Track which item is being edited
  String inputValue = '';
  int totalCorrect = 0;
  int totalWrong = 0;

  List<Map<String, dynamic>> items = [
    {'value': 1, 'imagePath': 'assets/icon/ball.png'},
    {'value': 2, 'imagePath': 'assets/icon/crayons.png'},
    {'value': 3, 'imagePath': 'assets/icon/microscope.png'},
    {'value': 4, 'imagePath': 'assets/icon/notebook.png'},
    {'value': 5, 'imagePath': 'assets/icon/paperclip.png'},
    {'value': 6, 'imagePath': 'assets/icon/ruler.png'},
    {'value': 7, 'imagePath': 'assets/icon/sharpener.png'},
    {'value': 8, 'imagePath': 'assets/icon/toy.png'},
  ];

  void _handleItemClick(int value, String? imagePath, bool isFirstSlot) {
    setState(() {
      if (isFirstSlot) {
        item1 = value;
        item1ImagePath = imagePath;
      } else {
        item2 = value;
        item2ImagePath = imagePath;
      }
      _calculateResult();
    });
  }

  void _handleOperation(String selectedOperation) {
    setState(() {
      operation = selectedOperation;
      _calculateResult();
    });
  }

  void _calculateResult() {
    switch (operation) {
      case '+':
        result = item1 + item2;
        break;
      case '-':
        result = item1 - item2;
        break;
      case '*':
        result = item1 * item2;
        break;
      case '/':
        if (item2 != 0) {
          result = item1 ~/ item2; // Integer division
        } else {
          result = 0; // Handle division by zero
        }
        break;
      default:
        result = 0;
    }
  }

  void _onSidebarItemTap(String operation) {
    _handleOperation(operation);
    setState(() {
      this.operation = operation;
      _calculateResult();
    });
  }

  void _editItem(BuildContext context, bool isFirstSlot) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Item"),
          content: SingleChildScrollView(
            child: Column(
              children: items.map((item) {
                return ListTile(
                  leading: item['imagePath'] != null
                      ? Image.asset(item['imagePath'], width: 30, height: 30)
                      : null,
                  title: Text('Item ${item['value']}'),
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      if (isFirstSlot) {
                        item1 = item['value'];
                        item1ImagePath = item['imagePath'];
                      } else {
                        item2 = item['value'];
                        item2ImagePath = item['imagePath'];
                      }
                      _calculateResult();
                    });
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void initState() {
    super.initState();
    operation = '+'; // Set addition as the default operation
    _calculateResult(); // Calculate the result initially
  }

  void _onButtonPressed(int value) {
    setState(() {
      if (value == -1) {
        if (inputValue.isNotEmpty) {
          inputValue = inputValue.substring(0, inputValue.length - 1);
        }
      } else {
        inputValue += value.toString();
      }
    });
  }

  void _toggleEditingItem() {
    setState(() {
      isEditingItem1 = !isEditingItem1;
    });
  }

  void _onEnterPressed() {
    setState(() {
      int inputAsInt = int.tryParse(inputValue) ?? 0;
      bool isCorrect = false;

      if (operation == '-') {
        int correctAnswer = result;
        isCorrect = inputAsInt == correctAnswer || inputAsInt == -correctAnswer;
      } else {
        int correctAnswer = result;
        isCorrect = inputAsInt == correctAnswer;
      }

      if (isCorrect) {
        totalCorrect++;
        _showResultDialog('Correct!', Colors.green);
      } else {
        totalWrong++;
        _showResultDialog('Try Again', Colors.red);
      }
      inputValue = '';
    });
  }

  void _onBackPressed() {
    setState(() {
      if (inputValue.isNotEmpty) {
        inputValue = inputValue.substring(0, inputValue.length - 1);
      }
    });
  }

  void _showResultDialog(String message, Color color) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: color,
          content: Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 24),
            textAlign: TextAlign.center,
          ),
        );
      },
    );

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      drawer: NavBar(onItemTap: _onSidebarItemTap),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(
                  color: const Color.fromARGB(
                      255, 255, 255, 255)), // Set the icon color to black
              title: Text(
                'Shop Calculator',
                style: GoogleFonts.magra(fontSize: 25, color: Colors.white),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Correct: $totalCorrect',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Wrong: $totalWrong',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Main content
          Column(
            children: [
              SizedBox(height: kToolbarHeight), // Space for the AppBar
              HeaderTitle(), // Include the HeaderTitle widget here
              Expanded(
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    if (orientation == Orientation.portrait) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Ball',
                                  value: 1,
                                  imagePath: 'assets/icon/ball.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/ball.png', true),
                                ),
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Crayons',
                                  value: 2,
                                  imagePath: 'assets/icon/crayons.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/crayons.png', true),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Microscope',
                                  value: 3,
                                  imagePath: 'assets/icon/microscope.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/microscope.png', true),
                                ),
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Notebook',
                                  value: 4,
                                  imagePath: 'assets/icon/notebook.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/notebook.png', true),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Paper clip',
                                  value: 5,
                                  imagePath: 'assets/icon/paperclip.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/paperclip.png', true),
                                ),
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Ruler',
                                  value: 6,
                                  imagePath: 'assets/icon/ruler.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/ruler.png', true),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Sharpener',
                                  value: 7,
                                  imagePath: 'assets/icon/sharpener.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/sharpener.png', true),
                                ),
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Toy',
                                  value: 8,
                                  imagePath: 'assets/icon/toy.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/toy.png', true),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                      // orientation mode
                    } else {
                      return Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Ball',
                                  value: 1,
                                  imagePath: 'assets/icon/ball.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/ball.png', true),
                                ),
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Crayons',
                                  value: 2,
                                  imagePath: 'assets/icon/crayons.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/crayons.png', true),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Microscope',
                                  value: 3,
                                  imagePath: 'assets/icon/microscope.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/microscope.png', true),
                                ),
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Notebook',
                                  value: 4,
                                  imagePath: 'assets/icon/notebook.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/notebook.png', true),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Paper clip',
                                  value: 5,
                                  imagePath: 'assets/icon/paperclip.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/paperclip.png', true),
                                ),
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Ruler',
                                  value: 6,
                                  imagePath: 'assets/icon/ruler.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/ruler.png', true),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Sharpener',
                                  value: 7,
                                  imagePath: 'assets/icon/sharpener.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/sharpener.png', true),
                                ),
                                SingleItemContainer(
                                  color: Color.fromRGBO(136, 117, 94, 1.000),
                                  text: 'Toy',
                                  value: 8,
                                  imagePath: 'assets/icon/toy.png',
                                  onTap: () => _handleItemClick(
                                      1, 'assets/icon/toy.png', true),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              //end of the items
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(176, 167, 150, 1.000),
                  border: Border.all(
                    color: Colors.black, // Black border color
                    width: 7.0, // Border width
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _editItem(context, true),
                      child: Row(
                        children: [
                          if (item1ImagePath != null)
                            Image.asset(
                              item1ImagePath!,
                              width: 30,
                              height: 30,
                            ),
                          SizedBox(width: 10),
                          Text(
                            '$item1',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontFamily: 'Teko',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      operation,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => _editItem(context, false),
                      child: Row(
                        children: [
                          if (item2ImagePath != null)
                            Image.asset(
                              item2ImagePath!,
                              width: 30,
                              height: 30,
                            ),
                          SizedBox(width: 10),
                          Text(
                            '$item2',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontFamily: 'Teko',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      '= ',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 95, // Set the desired width
                      height: 50, // Set the desired height
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            operation == '-' && result < 0
                                ? '-${inputValue.isEmpty ? '?' : inputValue}'
                                : inputValue.isEmpty
                                    ? '?'
                                    : inputValue,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontFamily: 'Teko',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // result section

          //end of the container

          // Other widgets can be added here
        ],
      ),
      persistentFooterButtons: [
        IndependentButtons(
          onButtonPressed: _onButtonPressed,
          onEnterPressed: _onEnterPressed,
          onBackPressed: _onBackPressed,
        ),
      ],
    );
  }
}

class SingleItemContainer extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  final String? imagePath;
  final VoidCallback onTap;
  final double width;
  final double height;

  SingleItemContainer({
    required this.color,
    required this.text,
    required this.value,
    this.imagePath,
    required this.onTap,
    this.width = 85.0, // Default width
    this.height = 120.0, // Default height
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.all(1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Image.asset(
                imagePath!,
                width: 75,
                height: 75,
              ),
            Text(
              '$text:',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Text(
              '$value',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

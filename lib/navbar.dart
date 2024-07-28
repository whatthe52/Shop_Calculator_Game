import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final Function(String) onItemTap;

  NavBar({required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(242, 92, 45, 1.00),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Operations',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 8), // Space between header and note
                Text(
                  'Note: From the items shown, Select from the bottom between the operations then tap the number buttons to answer. If you\'re done, hit the green button and see the result. Have Fun!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis, // Handle overflow
                  maxLines: 4, // Limit to 4 lines
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text('Addition'),
                  onTap: () {
                    onItemTap('+');
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  leading: Icon(Icons.remove),
                  title: Text('Subtraction'),
                  onTap: () {
                    onItemTap('-');
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  leading: Icon(Icons.clear),
                  title: Text('Multiplication'),
                  onTap: () {
                    onItemTap('*');
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  leading: Icon(Icons.horizontal_split),
                  title: Text('Division'),
                  onTap: () {
                    onItemTap('/');
                    Navigator.pop(context); // Close the drawer
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

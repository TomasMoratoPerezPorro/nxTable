import 'package:flutter/material.dart';

class OrBar extends StatelessWidget {
  final double spaceTop, spaceBottom;
  OrBar({this.spaceBottom = 24, this.spaceTop = 24});

  @override
  Widget build(BuildContext context) {
    final grey = Colors.grey[400];
    final line = Expanded(child: Container(height: 1, color: grey));
    return Padding(
      padding: EdgeInsets.fromLTRB(0, spaceTop, 0, spaceBottom),
      child: Row(
        children: <Widget>[
          line,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'or',
              style: TextStyle(
                color: grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          line,
        ],
      ),
    );
  }
}

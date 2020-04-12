import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({@required this.text, @required this.destination, this.color});
  final String text;
  final String destination;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            //Go to login screen.
            Navigator.pushNamed(context, destination);
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}

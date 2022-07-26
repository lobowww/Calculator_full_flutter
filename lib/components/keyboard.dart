import 'package:flutter/material.dart';
import 'button.dart';
import 'button_row.dart';

class Keyboard extends StatelessWidget {
  final void Function(String) rK;

  Keyboard(this.rK);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: <Widget>[
          ButtonRow([
            Button.bigButton(text: 'AC', color: Button.DARK, rK: rK),
            Button(text: '%', color: Button.DARK, rK: rK),
            Button.operation(text: '/', rK: rK),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(text: '7', rK: rK),
            Button(text: '8', rK: rK),
            Button(text: '9', rK: rK),
            Button.operation(text: 'x', rK: rK),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(text: '4', rK: rK),
            Button(text: '5', rK: rK),
            Button(text: '6', rK: rK),
            Button.operation(text: '-', rK: rK),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(text: '1', rK: rK),
            Button(text: '2', rK: rK),
            Button(text: '3', rK: rK),
            Button.operation(text: '+', rK: rK),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button.bigButton(text: '0', rK: rK),
            Button(text: '.', rK: rK),
            Button.operation(text: '=', rK: rK),
          ]),
        ],
      ),
    );
  }
}

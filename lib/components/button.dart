import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const DARK = Color.fromRGBO(82, 82, 82, 1);
  static const DEFAULT = Color.fromRGBO(112, 112, 112, 1);
  static const OPERATION = Color.fromRGBO(250, 158, 13, 1);

  final String text;
  final bool bigButton;
  final Color color;
  final void Function(String) rK; //returnKeyboard

  Button({
    required this.text,
    this.bigButton = false,
    this.color = DEFAULT,
    required this.rK,
  });
  Button.bigButton({
    required this.text,
    this.bigButton = true,
    this.color = DEFAULT,
    required this.rK,
  });
  Button.operation({
    required this.text,
    this.bigButton = false,
    this.color = OPERATION,
    required this.rK,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: bigButton ? 2 : 1,
      child: RaisedButton(
        color: this.color,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w200,
          ),
        ),
        onPressed: () => rK(text), //arrow function
      ),
    );
  }
}

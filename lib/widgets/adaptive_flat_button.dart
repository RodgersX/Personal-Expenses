import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final VoidCallback handler;

  AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return FlatButton(
      textColor: Theme.of(context).primaryColor,
      onPressed: handler,
      child: const Text(
        'Choose date',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

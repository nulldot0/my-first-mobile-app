import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String _name;

  TodoItem(this._name);

  @override
  Widget build(BuildContext context) {
    return Text(
      _name,
    );
  }
}

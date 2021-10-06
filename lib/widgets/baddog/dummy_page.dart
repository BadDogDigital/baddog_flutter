import 'package:flutter/material.dart';

class DummyPage extends StatefulWidget {
  DummyPage({
    Key? key,
    this.color = Colors.red,
  }) : super(key: key);

  final Color color;

  @override
  _DummyPageState createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey,
        width: double.infinity,
        height: double.infinity);
  }
}

import 'package:flutter/material.dart';

class NewsCardListEditTemplate extends StatefulWidget {
  const NewsCardListEditTemplate({Key? key, required this.data})
      : super(key: key);
  final Map data;

  @override
  _NewsCardListEditTemplateState createState() =>
      _NewsCardListEditTemplateState();
}

class _NewsCardListEditTemplateState extends State<NewsCardListEditTemplate> {
  final TextEditingController expandController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${this.widget.data}'),
    );
  }
}

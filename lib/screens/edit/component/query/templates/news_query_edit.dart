import 'package:baddog_flutter/screens/edit/widgets/edit_key_value_pair.dart';
import 'package:flutter/material.dart';

//BaseNewsQuery
//I suppose you would have multiple classes in this one file
//GnewsSearchQueryEdit for example - come up with a standard
class NewsQueryTemplate extends StatefulWidget {
  const NewsQueryTemplate({Key? key, required this.data}) : super(key: key);
  final Map data;
  get params => data['parameters'];

  @override
  _NewsQueryTemplateState createState() => _NewsQueryTemplateState();
}

class _NewsQueryTemplateState extends State<NewsQueryTemplate> {
  final TextEditingController qController = TextEditingController();
  final TextEditingController topicController = TextEditingController();
  final TextEditingController langController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController maxController = TextEditingController();
  final TextEditingController pageController = TextEditingController();
  final TextEditingController nullableController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController expandController = TextEditingController();

  void initState() {
    print('DATA ${widget.data['parameters']}');
    print('DATA ${widget.data}');
    print('PARAMS ${widget.params}');
    qController.text = widget.params['q'] ?? '';
    topicController.text = widget.params['topic'] ?? '';
    langController.text = widget.params['lang'] ?? 'en';
    countryController.text = widget.params['country'] ?? 'GB';
    maxController.text = widget.params['max'] ?? '';
    pageController.text = widget.params['page'] ?? '1';
    nullableController.text = widget.params['nullable'] ?? '';
    fromController.text = widget.params['from'] ?? '';
    toController.text = widget.params['to'] ?? '';
    expandController.text = widget.params['expand'] ?? '';

    super.initState();
  }

  Map onSave() {
    return {
      'q': qController.text,
      'topic': topicController.text,
      'lang': langController.text,
      'country': countryController.text,
      'max': maxController.text,
      'page': pageController.text,
      'nullable': nullableController.text,
      'from': fromController.text,
      'to': toController.text,
      'expand': expandController.text,
    };
  }

  //Should be a form no?
  List<Widget> _createParametersList() {
    return [
      //_createKeyPair('q', qController),
      StringKeyValue(keyVal: 'q', controller: qController),
      StringKeyValue(keyVal: 'topic', controller: topicController),
      StringKeyValue(keyVal: 'lang', controller: langController),
      StringKeyValue(keyVal: 'country', controller: countryController),
      StringKeyValue(
        keyVal: 'max',
        controller: maxController,
        inputType: 'number',
      ),
      StringKeyValue(
        keyVal: 'page',
        controller: pageController,
        inputType: 'number',
      ),
      StringKeyValue(keyVal: 'nullable', controller: nullableController),
      StringKeyValue(keyVal: 'from', controller: fromController),
      StringKeyValue(keyVal: 'to', controller: toController),
      StringKeyValue(keyVal: 'expand', controller: expandController),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _createParametersList(),
    );
  }
}

import 'package:flutter/material.dart';

class StringKeyValue extends StatefulWidget {
  StringKeyValue({
    Key? key,
    required this.keyVal,
    required this.controller,
    this.inputType,
  }) : super(key: key);

  final String keyVal;
  final TextEditingController controller;
  String? inputType = 'text';

  @override
  _StringKeyValueState createState() => _StringKeyValueState();
}

class _StringKeyValueState extends State<StringKeyValue> {
  late TextInputType _inputType;

//doesn't work?
  void _assignInputType() {
    switch (widget.inputType) {
      case 'text':
        _inputType = TextInputType.text;
        break;
      case 'number':
        print('Number type');
        _inputType = TextInputType.number;
        break;
      case 'datetime':
        _inputType = TextInputType.datetime;
        break;
      case 'emailAddress':
        _inputType = TextInputType.emailAddress;
        break;
      case 'multiline':
        _inputType = TextInputType.multiline;
        break;
      case 'phone':
        _inputType = TextInputType.phone;
        break;
      case 'streetAddress':
        _inputType = TextInputType.streetAddress;
        break;
      case 'url':
        _inputType = TextInputType.url;
        break;
      case 'visiblePassword':
        _inputType = TextInputType.visiblePassword;
        break;

      default:
        _inputType = TextInputType.text;
    }
    print('type ${_inputType}');
  }

  @override
  void initState() {
    _assignInputType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //arbitrary perhaps? better way of doing Expanded()
      child: Row(
        children: [
          Text('${widget.keyVal}: '),
          Expanded(
            child: TextField(
              controller: widget.controller,
              keyboardType: _inputType,
            ),
          ),
        ],
      ),
    );
  }
}

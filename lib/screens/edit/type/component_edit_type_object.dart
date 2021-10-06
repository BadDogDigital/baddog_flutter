import 'package:flutter/material.dart';

class EditComponentTypeObject extends StatefulWidget {
  const EditComponentTypeObject({Key? key, required this.data})
      : super(key: key);
  final Map data;
  @override
  _EditComponentTypeObjectState createState() =>
      _EditComponentTypeObjectState();
}

class _EditComponentTypeObjectState extends State<EditComponentTypeObject> {
  Widget _createMapLine(String key, String val, Function hnd) {
    return Row(
      children: [
        Text('$key: '),
        Text('$val'),
      ],
    );
  }

  Widget _createContentWidget() {
    return _createMapLine('content', widget.data['content'], () => {});
  }

  Widget _createErrorWidget() {
    return _createMapLine('error', widget.data['error'], () => {});
  }

  Widget _createLoadingWidget() {
    return _createMapLine('loading', widget.data['loading'], () => {});
  }

  Widget _createTypeWidget() {
    return _createMapLine('type', widget.data['type'], () => {});
  }

  Widget _createWrapperWidget() {
    return _createMapLine('wrapper', widget.data['wrapper'], () => {});
  }

//type Widgets
  List<Widget> _createTypeList() {
    List<Widget> returnList = [];

    returnList.add(_createTypeWidget());
    returnList.add(_createWrapperWidget());
    returnList.add(_createContentWidget());
    returnList.add(_createLoadingWidget());
    returnList.add(_createErrorWidget());

    return returnList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _createTypeList(),
    );
  }
}

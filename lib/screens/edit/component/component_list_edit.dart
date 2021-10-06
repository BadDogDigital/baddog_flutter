import 'package:baddog_flutter/models/gridview/gridview_model.dart';
import 'package:baddog_flutter/screens/edit/component/component_edit.dart';
import 'package:flutter/material.dart';

class ComponentListEdit extends StatelessWidget {
  const ComponentListEdit({Key? key, required this.data}) : super(key: key);

  //We need documentId;
  final GridViewModel data;

  Widget _createComponentList() {
    var items = data.gridItems;
    var i = 0;
    List<Widget> drawItems = [];
    items.forEach((it) {
      drawItems.add(_createComponentItem(it, i));
      i++;
    });
    return Column(
      children: drawItems,
    );
  }

  Widget _createComponentItem(item, index) {
    return Column(
      children: [
        Text('$index'),
        ComponentEdit(
          data: item,
        ),
      ],
    );
  }

  Widget _createComponentListTitle() {
    return Container(
      child: Text('${data.id}'),
    );
  }

  Widget _createItemsField() {
    return Container(
      child: Text('Items'),
    );
  }

  Widget _createComponentEditBody() {
    return Container(
      child: Column(
        children: [
          _createComponentListTitle(),
          _createItemsField(),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: _createComponentList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //load login appbar
        title: Text('Component Edit - ${this.data.id}'),
      ),
      body: _createComponentEditBody(),
    );
  }
}

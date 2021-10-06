import 'package:baddog_flutter/screens/edit/component/params/component_edit_params_view.dart';
import 'package:baddog_flutter/screens/edit/component/query/component_edit_query_view.dart';
import 'package:baddog_flutter/screens/edit/type/component_edit_type_object.dart';
import 'package:flutter/material.dart';

//This should really show a list of component objects in a list
//Controls for editing list
//Each Component id links to an actual component

class ComponentEdit extends StatefulWidget {
  const ComponentEdit({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Map data;
  @override
  _ComponentEditState createState() => _ComponentEditState();
}

class _ComponentEditState extends State<ComponentEdit> {
  Widget _createParamsView() {
    //load a template based on type and then fill with our data
    return Column(
      children: [
        Text('params:'),
        EditComponentParamsView(
            type: widget.data['type'], data: widget.data['params']),
      ],
    );
  }

  Widget _createTypeView() {
    //generic to all Component objects
    return Column(
      children: [
        Text('type:'),
        EditComponentTypeObject(data: widget.data['type']),
      ],
    );
  }

  Widget _createQueryView() {
    //load a template based on the Query used / fill with our data
    //load a thing and pass in a map of data
    return Column(
      children: [
        Text('query:'),
        EditComponentQueryView(data: widget.data['query']),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print('DATA ${widget.data}');
    return Column(
      children: [
        _createTypeView(),
        _createParamsView(),
        _createQueryView(),
      ],
    );
  }
}

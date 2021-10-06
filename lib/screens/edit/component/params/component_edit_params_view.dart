import 'package:baddog_flutter/screens/edit/component/params/params_type_factory.dart';
import 'package:flutter/material.dart';

class EditComponentParamsView extends StatefulWidget {
  const EditComponentParamsView(
      {Key? key, required this.type, required this.data})
      : super(key: key);

  final Map data;
  final Map type; //required to get the Object type for template
  get typeId => type['type'];

  @override
  _EditComponentParamsView createState() => _EditComponentParamsView();
}

class _EditComponentParamsView extends State<EditComponentParamsView> {
  Widget _loadAndReturnTemplate() {
    return ComponentTypeFactory.getTemplate(
      typeId: widget.typeId,
      data: widget.data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _loadAndReturnTemplate();
  }
}

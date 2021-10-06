import 'package:baddog_flutter/screens/edit/component/query/query_type_factory.dart';
import 'package:flutter/material.dart';

class EditComponentQueryView extends StatefulWidget {
  const EditComponentQueryView({Key? key, required this.data})
      : super(key: key);
  final Map data;
  @override
  _EditComponentQueryView createState() => _EditComponentQueryView();
}

//this seems an arbitrary step - just call factory?
class _EditComponentQueryView extends State<EditComponentQueryView> {
  Widget _loadAndReturnQueryTemplate() {
    print('${widget.data['type']}');
    print('${widget.data['name']}');
    print('${widget.data['query_id']}');

    return EditComponentQueryFactory.getTemplate(
      typeId: widget.data['type'],
      data: widget.data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _loadAndReturnQueryTemplate();
  }
}

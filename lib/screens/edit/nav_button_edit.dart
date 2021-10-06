import 'package:baddog_flutter/models/gridview/gridview_model.dart';
import 'package:baddog_flutter/providers/gridview/firestore_gridview.dart';
import 'package:baddog_flutter/screens/edit/component/component_list_edit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class NavigationButtonEdit extends StatefulWidget {
  const NavigationButtonEdit(
      {Key? key, required this.data, required this.index, required this.onSave})
      : super(key: key);

  final Map data;
  final int index;
  final Function onSave;

  @override
  _NavigationButtonEditState createState() => _NavigationButtonEditState();
}

class _NavigationButtonEditState extends State<NavigationButtonEdit> {
  final TextEditingController textController =
      TextEditingController(); //text change
  final TextEditingController subController =
      TextEditingController(); //more like search
  final TextEditingController urlController =
      TextEditingController(); //text change
  final TextEditingController contentController =
      TextEditingController(); //would be more click delete, click new

//Should have a thing
  Map generateButtonReturn() {
    return {
      'text': textController.text,
      'sub': subController.text,
      'url': urlController.text,
      'content': contentController.text
    };
  }

  @override
  void initState() {
    //probably better in their respective functions
    textController.text = widget.data['text'];
    subController.text = widget.data['sub'];
    urlController.text = widget.data['url'];
    contentController.text = widget.data['content'];
    super.initState();
    //sl.registerSingleton<FirestoreGridView>(FirestoreGridView());
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    subController.dispose();
    urlController.dispose();
    contentController.dispose();
    //sl.unregister<FirestoreGridView>(FirestoreGridView());

    super.dispose();
  }

  //as a test for propogating events
  //works nicely
  onPressedHnd() {
    //our callback handler to update the state
    widget.onSave(generateButtonReturn(), widget.index);
  }

  void _loadPageContent() {}

  Future<GridViewModel> _loadContent(BuildContext context) async {
    GridViewModel dta = await sl<FirestoreGridView>()
        .getGridViewDataByDocId(id: contentController.text);
    print("HERE $dta");
    //basically load component edit
    _loadComponentEditLoginPage(context, dta);
    return dta;
  }

  Widget _createIconButton(Widget icon, String tooltip, hnd, Alignment? align) {
    Alignment _align = align ?? Alignment.center;
    return IconButton(
      icon: icon,
      onPressed: hnd,
      color: Colors.grey[700],
      tooltip: tooltip,
      alignment: _align,
    );
  }

  Widget createIndexEntry() {
    return Row(
      children: [
        Expanded(
          child: Text('Index: ${widget.index}'),
          flex: 1,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child:
                _createIconButton(Icon(Icons.delete), 'delete', () => {}, null),
          ),
          flex: 1,
        ),
      ],
    );
  }

  Widget createTextEntry() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text('text: '),
        Expanded(
          child: TextField(
            controller: textController,
          ),
        ),
        _createIconButton(Icon(Icons.edit), 'edit', () => {}, null),
      ],
    );
  }

  Widget createSubEntry() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text('sub: '),
        Expanded(
          child: TextField(
            controller: subController,
            readOnly: true,
          ),
        ),
        _createIconButton(Icon(Icons.edit), 'edit', () => {}, null),
        _createIconButton(Icon(Icons.delete), 'delete', () => {}, null),
      ],
    );
  }

  Widget createUrlEntry() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text('url: '),
        Expanded(
          child: TextField(
            controller: urlController,
            readOnly: true,
          ),
        ),
        _createIconButton(Icon(Icons.edit), 'edit', () => {}, null),
      ],
    );
  }

  Widget createContentEntry() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text('content: '),
        Expanded(
          child: TextField(
            readOnly: true,
            onTap: () => {_loadContent(context)},
            controller: contentController,
          ),
        ),
        _createIconButton(Icon(Icons.edit), 'edit', () => {}, null),
        _createIconButton(Icon(Icons.delete), 'delete', () => {}, null),
      ],
    );
  }

  void _loadComponentEditLoginPage(BuildContext context, GridViewModel data) {
    //pass in componant data and kablammo
    //We're listing off
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ComponentListEdit(data: data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0),
      child: Column(
        children: [
          createIndexEntry(),
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Column(
              //probably out to a widget of its own
              children: [
                createTextEntry(),
                createSubEntry(),
                createUrlEntry(),
                createContentEntry(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

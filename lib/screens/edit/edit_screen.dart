import 'package:baddog_flutter/models/navigation/navigation_model.dart';
import 'package:baddog_flutter/providers/navigation/firestore_navigation.dart';
import 'package:baddog_flutter/screens/edit/nav_button_edit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

//This should probably be a whole new page
//Navigate to Edit page
//Then when we Edit/Create a component we can 'navigate' to a new page
//Stack -> Main -> Edit -> ComponentEdit

GetIt sl = GetIt.instance;

//Are you logged in?
//If so - Get User nav
//Load edit accordingly

//BaseEdit is Nav Edit really
class BaseEdit extends StatefulWidget {
  const BaseEdit({Key? key}) : super(key: key);

  @override
  _BaseEditState createState() => _BaseEditState();
}

class _BaseEditState extends State<BaseEdit> {
  late MainNavigation _navData;
  List _navButtons = [];
  String _navId = '';

  _getNavData() async {
    _navData = await sl<FirestoreNavigation>().getNavigationData(id: 'main');
    _navButtons = _navData.buttons;
    _navId = _navData.id;

    setState(() {});
  }

  Widget _createButtonsLabel() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      //mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Text('Buttons '),
          flex: 1,
        ),
        Expanded(
          child: Container(
            //Align CHILD
            alignment: Alignment.centerRight,
            child: IconButton(
              //This aligned child but not the onPress animation
              //alignment: Alignment.centerRight,
              icon: Icon(Icons.add),
              onPressed: () => {},
              color: Colors.grey[700],
              tooltip: 'Add New Button',
            ),
          ),
          flex: 1,
        ),
      ],
    );
  }

  Widget _createNavIdLabel() {
    return Text('id: $_navId ');
  }

  _buttonSaved(dta, index) {
    print("SAVED $dta - $index");
  }

  ListView _createNavEdit() {
    int i = 0;
    //Change this
    List<Widget> returnDta = [
      _createNavIdLabel(),
      _createButtonsLabel(),
    ];
    //just do a for
    _navButtons.forEach((element) {
      returnDta.add(NavigationButtonEdit(
        data: element,
        index: i,
        onSave: _buttonSaved,
      ));
      i++;
    });
    return ListView(
      children: returnDta,
      padding: const EdgeInsets.all(8),
    );
  }

  @override
  initState() {
    super.initState();
    _getNavData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: _createNavEdit());
  }
}

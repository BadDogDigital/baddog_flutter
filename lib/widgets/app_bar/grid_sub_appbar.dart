import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:baddog_flutter/providers/navigation/firestore_navigation.dart';
import 'package:baddog_flutter/models/navigation/navigation_model.dart';

GetIt sl = GetIt.instance;

//https://stackoverflow.com/questions/62564347/flutter-how-to-implement-a-custom-app-bar-usage-and-re-usage
class GridAppBar extends StatefulWidget implements PreferredSizeWidget {
  //
  const GridAppBar({
    Key? key,
  });

  @override
  _GridAppBar createState() => _GridAppBar();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight); //kToolbarHeight
}

class TabObject {
  String text;
  TabObject({required this.text});
}

//
class _GridAppBar extends State<GridAppBar> with TickerProviderStateMixin {
  //single seems to only ever allow one ticker built
  //We are disposing of our ticker to redo - is this okay?
  //with SingleTickerProviderStateMixin {
  ///kToolbar height is a Flutter constant - 56.0

  late TabController _tabController;
  late MainNavigation _navData;

  //This works as is but importing from external file/database?
  //So do it / we have Firestore
  //Sub nav and back to upper nav
  //rewrite the thing each layer?
  List<TabObject> obj = [];

  List<TabObject> _createTabs(btnDta) {
    List<TabObject> obj = [];
    btnDta.forEach((btn) {
      print(btn);
      obj.add(TabObject(text: btn['text']));
    });

    return obj;
  }

//put nav stuff somewhere no?
  _getNavData() async {
    _navData = await sl<FirestoreNavigation>().getNavigationData(id: 'main');

    obj = _createTabs(_navData.buttons);

    _tabController =
        new TabController(length: _navData.buttons.length, vsync: this);
    _tabController.addListener(_tabButtonSelection);

    setState(() {});
  }

  @override
  initState() {
    super.initState();
    _tabController = new TabController(length: obj.length, vsync: this);
    _tabController.addListener(_tabButtonSelection);
    //need the length from somewhere / povided data would be here
    _getNavData(); //where and how
    print("Just checking!");
  }

  void _tabButtonSelection() {
    if (_tabController.indexIsChanging) {
      print("TABCONTROLLER ${_tabController.index}");

      //pass current view object id to view to update
      //if there's a sub nav update nav

      //get tab from list of tabs
      //How to do sub nav?? / rewrite nav and provide a back/breadcrumbs
      //update grid screen
    }
  }

  List<Widget> _tabBarButtons() {
    List<Widget> woops = [];

    obj.forEach((item) {
      Tab thing = Tab(
        text: item.text,
      );
      woops.add(thing);
    });

    return woops;
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabButtonSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      primary: false,

      bottom: TabBar(
        controller: _tabController,
        tabs: _tabBarButtons(),
        isScrollable: true,
        indicatorColor: Colors.deepOrange,
        indicatorWeight: 5,
      ),
    );
  }
}

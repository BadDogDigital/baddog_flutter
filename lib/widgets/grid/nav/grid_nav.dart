import 'package:baddog_flutter/widgets/grid/nav/item/grid_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:baddog_flutter/models/gridnav/gridnav_model.dart';

GetIt sl = GetIt.instance;

class GridNavigation extends StatefulWidget {
  const GridNavigation({Key? key}) : super(key: key);

  @override
  _GridNavigationState createState() => _GridNavigationState();
}

//We somehow need a duel scroll
class _GridNavigationState extends State<GridNavigation>
    with TickerProviderStateMixin {
  int _number = 5;

  //This works - coming back yet to test
  //But needs to resize main screen
  //Twitter logos remain!!
  double _size = double.infinity; //hmm?
  void _updateSize() {
    setState(() {
      _size = 0;
    });
  }

  //Utilising a service seems overkill?
  //but dispatching up seems worse?
  _gridNavTap(index) {
    print("GRID NAV TAPPED $index");
    if (index != sl<GridNavModel>().currentIndex)
      sl<GridNavModel>().currentIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.easeIn,
      duration: const Duration(seconds: 1),
      vsync: this,
      child: Container(
        width: _size,
        child: Column(
          //need by number of passed in gridItems
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.end,

          children: <Widget>[
            /*TextButton(
              //this actually works lulz
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                print('PRESSED BUTTON');
              },
              child: Text(' '),
            ),
            InkWell(
              child: Container(
                width: double.infinity,
                height: 20,
                color: Colors.blueAccent,
              ),
              onTap: () {
                print('PRESSED IT');
                _updateSize();
              },
            ),*/
            GridNavItem(
              index: 0,
              color: Colors.red,
              onTap: _gridNavTap,
            ),
            GridNavItem(
              index: 1,
              color: Colors.blue,
              onTap: _gridNavTap,
            ),
            GridNavItem(
              index: 2,
              color: Colors.green,
              onTap: _gridNavTap,
            ),
            GridNavItem(
              index: 3,
              color: Colors.yellow,
              onTap: _gridNavTap,
            ),
            GridNavItem(
              index: 4,
              color: Colors.amber,
              onTap: _gridNavTap,
            ),
          ],
        ),
      ),
    );
  }
}

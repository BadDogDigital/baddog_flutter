import 'package:baddog_flutter/widgets/app_bar/grid_sub_appbar.dart';
import 'package:baddog_flutter/widgets/grid/body/mobile_gridlist.dart';
import 'package:baddog_flutter/widgets/grid/item/grid_item.dart';
import 'package:baddog_flutter/widgets/grid/nav/grid_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
//import 'package:flutter_layout_grid/flutter_layout_grid.dart';

//import 'package:get_it/get_it.dart';

//GetIt sl = GetIt.instance;

class GridBody extends StatefulWidget {
  const GridBody({
    Key? key,
  }) : super(key: key);

  @override
  _GridBodyState createState() => _GridBodyState();
}

class _GridBodyState extends State<GridBody> {
  Widget _returnGrid(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    print('Width dammit $w');
    if (w <= 600.0)
      return MobileGrid();
    else
      return Placeholder(); //middle & big grid
  }

  //listening in the wrong place
  //_navChanged() {
  //  var oof = sl<GridNavModel>().currentIndex;
  //  print('NAV CHANGED CURRENT INDEX $oof');
  //}

  @override
  void initState() {
    //sl.registerSingleton<GridNavModel>(GridNavModel(numOfItems: 3));
    //sl<GridNavModel>().addListener(_navChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var oof = sl<GridNavModel>().currentIndex;
    //print('CURRENT INDEX $oof');
    //This will be highly dependent on Media Query no?
    //Effectively at this point media query the hell out of this thing
    //return the given data accordingly
    //Our grid body at this point is a list / or on mobile is a list
    return _returnGrid(context);
  }
}

//split this off
class MobileGrid extends StatelessWidget {
  const MobileGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: GridAppBar(),
      body: LayoutGrid(
        areas: '''
        view right
        ''',
        columnSizes: [
          1.fr, // contributes width to [content, header, footer]
          56.px,
        ],
        rowSizes: [
          1.fr // contributes height to [nav, content]
        ],
        //GridNavigation seems MobileGridList
        //return array of children per MediaQuery
        children: [
          GridItem(
            columnStart: 0,
            columnSpan: 1,
            rowStart: 0,
            rowSpan: 1,
            child: MobileGridList(),
          ),
          GridItem(
            columnStart: 1,
            columnSpan: 1,
            rowStart: 0,
            rowSpan: 1,
            child: GridNavigation(),
          ),
        ],
      ),
    );
  }
}

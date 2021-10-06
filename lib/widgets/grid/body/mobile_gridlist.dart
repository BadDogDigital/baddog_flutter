import 'package:baddog_flutter/models/gridview/gridview_model.dart';
import 'package:baddog_flutter/widgets/grid/factory/grid_item_factory.dart';
import 'package:flutter/material.dart';
import 'package:baddog_flutter/providers/gridview/firestore_gridview.dart';

import 'package:baddog_flutter/models/gridnav/gridnav_model.dart';

import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

class MobileGridList extends StatefulWidget {
  MobileGridList({Key? key}) : super(key: key);

  @override
  _MobileGridListState createState() => _MobileGridListState();
}

class _MobileGridListState extends State<MobileGridList> {
  final PageController _pageController = PageController(initialPage: 0);
  late GridViewModel _listData;
  bool _dataLoaded = false;

  void _updateNav() {
    var index = sl<GridNavModel>().currentIndex;
    print('NAV CHANGED CURRENT INDEX $index');
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  _getListData() async {
    _listData =
        await sl<FirestoreGridView>().getGridViewData(id: 'MainGridView');
    print('LIST DATA $_listData');
    _dataLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    //How do we control this? (Dependency Injection but that requires a proper framework)
    //We could end up with a lot peppered about the place
    sl.registerSingleton<GridNavModel>(GridNavModel(numOfItems: 3));
    sl<GridNavModel>().addListener(_updateNav);

    _getListData();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    sl<GridNavModel>().removeListener(_updateNav);
    sl.unregister<GridNavModel>();
    super.dispose();
  }

  List<Widget> _createGridList({required GridViewModel data}) {
    List list = data.gridItems;

    List<Widget> returnList = [];
    list.forEach((dta) => {returnList.add(_createGridItem(dta))});
    return returnList;
  }

  //need to create model class objects all the way down
  Widget _createGridItem(item) {
    print("ItemData $item");

    //This is a 'type' factory?
    //Create QueryType, Static type
    //which can then facory up which type it is
    return GridItemFactory.createGridItemWrapper(
      type: item['type'],
      params: item['params'],
      query: item['query'],
    );
  }

  List<Widget> _produceChildren() {
    List<Widget> children = _createGridList(
      data: _listData,
    );

    return children;
  }

  @override
  Widget build(BuildContext context) {
    //final PageController controller = PageController(initialPage: 0);

    //function for drawPageView but okay this is straight forward
    if (_dataLoaded)
      return PageView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        controller: _pageController,
        children: _produceChildren(),
      );

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: _pageController,
      children: [Text('Not Loaded :(')],
    );
  }
}

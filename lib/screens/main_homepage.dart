import 'package:baddog_flutter/providers/footer_nav/footer_nav_service.dart';
import 'package:baddog_flutter/screens/edit/edit_screen.dart';
import 'package:baddog_flutter/widgets/app_bar/baddog_main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:baddog_flutter/widgets/footer/baddog_main_footer.dart';
import 'package:baddog_flutter/widgets/grid/grid_body.dart';

import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;
enum Screen { FEED, EDIT }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //We need to listen for changes to the footer navigation
  //In order to change our body
  //We may need appbar tabbar to be a part of body however

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Screen _screen = Screen.FEED;

  void _footerNavigate() {
    //Do not like the idea of using index?
    print("FOOTER NAVIGATE ${sl<FooterNavService>().currentIndex}");
    //footer jazz get currently selected
    //open screen and redraw

    //dirty stopgap / but it works very well
    if (sl<FooterNavService>().currentIndex == 0) _screen = Screen.FEED;
    if (sl<FooterNavService>().currentIndex == 4) _screen = Screen.EDIT;

    setState(() {});
  }

  //Draw Grid Body
  //What about draw edit componant
  Widget _drawBody() {
    //would you set up a pageview though?
    //int ind = sl<FooterNavService>().currentIndex;
    //return by selected index

    print('SCREEN $_screen');
    if (_screen == Screen.FEED) return GridBody();
    if (_screen == Screen.EDIT) return BaseEdit();

    return GridBody(); //Prob 404 pants down
  }

  @override
  void initState() {
    //I don't think we should be initialising services anywhere other than the one place
    //at least without very good reason
    //hard coding ...
    //Sort these out geez // pass in footer info, that's all
    sl.registerSingleton<FooterNavService>(FooterNavService(numOfItems: 5));
    sl<FooterNavService>().addListener(_footerNavigate);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    sl<FooterNavService>().removeListener(_footerNavigate);
    sl.unregister<FooterNavService>();
    super.dispose();
  }

  //We would need to listen and change this for bottom navigation updates
  //navigation add page assumably
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: MainAppBar(widget: widget),
      body: _drawBody(), //create grid - call class widget
      bottomNavigationBar:
          MainFooter(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

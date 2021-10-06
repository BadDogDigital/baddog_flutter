import 'package:baddog_flutter/screens/main_homepage.dart';
import 'package:baddog_flutter/theme/config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:baddog_flutter/screens/authentication/login.dart';

GetIt sl = GetIt.instance;

//https://stackoverflow.com/questions/62564347/flutter-how-to-implement-a-custom-app-bar-usage-and-re-usage
class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  //
  const MainAppBar({
    Key? key,
    required this.widget,
  });

  //final String title;
  final MyHomePage widget;

  @override
  _MainAppBarState createState() => _MainAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight); //kToolbarHeight
}

class TabObject {
  String text;
  TabObject({required this.text});
}

//
class _MainAppBarState extends State<MainAppBar> with TickerProviderStateMixin {
  //single seems to only ever allow one ticker built
  //We are disposing of our ticker to redo - is this okay?
  //with SingleTickerProviderStateMixin {
  ///kToolbar height is a Flutter constant - 56.0

  //This works as is but importing from external file/database?
  //So do it / we have Firestore
  //Sub nav and back to upper nav
  //rewrite the thing each layer?

  @override
  Widget build(BuildContext context) {
    print("We build early :(");
    return AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      primary: true,
      leading: Placeholder(),
      title: Text(widget.widget.title),
      //buttons elsewhere - return an array based on givens surely
      actions: [
        IconButton(
          icon: const Icon(Icons.login),
          onPressed: () => _navigateToLoginPage(context),
        ),
        IconButton(
          icon: const Icon(Icons.brightness_4),
          onPressed: () => currentTheme.toggleTheme(),
        ),
      ],
    );
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmailSignIn()),
    );
  }
}

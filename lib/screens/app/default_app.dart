import 'package:baddog_flutter/models/gridnav/gridnav_model.dart';
import 'package:baddog_flutter/providers/authentication/firebase_authentication.dart';
import 'package:baddog_flutter/providers/gridview/firestore_gridview.dart';
import 'package:baddog_flutter/providers/user/firestore_user.dart';
import 'package:flutter/material.dart';
import 'package:baddog_flutter/screens/main_homepage.dart';
import 'package:baddog_flutter/theme/config.dart'; //check this thing
import 'package:baddog_flutter/theme/custom_theme.dart';
import 'package:baddog_flutter/providers/navigation/firestore_navigation.dart';

import 'package:get_it/get_it.dart';

//If as a 'service layer' - we could load the data controller?
final sl = GetIt.instance;

class DefaultApp extends StatefulWidget {
  const DefaultApp({
    Key? key,
  }) : super(key: key);

  @override
  _DefaultAppState createState() => _DefaultAppState();
}

class _DefaultAppState extends State<DefaultApp> {
  //This should surely go elsewheres
  void setupServiceLayer() {
    //sl.registerSingleton<BadDogUser>(BadDogUser());

    //defaults to Uninitialised for now - need auto login check?
    //sl.registerSingleton<LoginModel>(LoginModel());
    sl.registerSingleton<FirebaseAuthentication>(FirebaseAuthentication());
    sl.registerSingleton<FirestoreUser>(FirestoreUser());
    //doesn't neccessarily need to be but lets leave this here
    sl.registerSingleton<FirestoreNavigation>(FirestoreNavigation());
    sl.registerSingleton<FirestoreGridView>(FirestoreGridView());

    //this has to be the start of overkill
    //sl.registerSingleton<GridNavModel>(GridNavModel())
  }

  @override
  void initState() {
    setupServiceLayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BadDogDigital',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      home: MyHomePage(title: 'Bad Dog Digital'),
    );
  }
}

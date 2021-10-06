import 'package:baddog_flutter/theme/config.dart';
import 'package:baddog_flutter/widgets/graphql/gql_app_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:baddog_flutter/screens/app/default_app.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

////////////////
///firebase main
///https://firebase.flutter.dev/docs/overview/#initializing-flutterfire
///Also FutureBuilder Main - Also Firebase
///Should split off Firebase from main into is own thing
///There's a reliance on cdn and config in the html though / don't like
///Will nedd work for IOS and Android
///////////////
void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); //What's this? / The glue apparently
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;
  //function calls outside of class
  //Should probably be elsewhere in an initialisation layer or some such
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
    //taken from config / prob should be in app screen rather than here
    //Also this doesn't seem like a good way utils function should be UTILS.
    currentTheme.addListener(() {
      //Understand and write this up
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      print('ERROR');
      return Placeholder();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      print('LOADING');
      return Placeholder();
    }

    ///We wrap our given 'App' in the graphQL provider
    return GraphAppWrapper(
      child: DefaultApp(),
    );
  }
}

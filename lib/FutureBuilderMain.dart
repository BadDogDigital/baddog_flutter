import 'package:baddog_flutter/theme/config.dart';
import 'package:flutter/material.dart';
import 'package:baddog_flutter/screens/app/default_app.dart';

import 'package:firebase_core/firebase_core.dart';

////////////////
///firebase main
///////////////
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Understand this properly and how handled / it feels cool as
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    super.initState();
    //taken from config / prob should be in app screen rather than here
    currentTheme.addListener(() {
      //Understand and write this up
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('ERROR PlaceHolder snapshot ');
          //print(snapshot.data);
          print(snapshot.error);
          return Placeholder(); //Error placeHolder
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print('Default App Okay');
          return DefaultApp();
        }

        print('LOADING PlaceHolder ');
        // Otherwise, show something whilst waiting for initialization to complete
        return Placeholder(); //Loading Animation
      },
    );
  }
}

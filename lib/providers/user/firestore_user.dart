import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:baddog_flutter/models/user/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
GetIt sl = GetIt.instance;

class FirestoreUser extends ChangeNotifier {
  BadDogUser _user = BadDogUser();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<DocumentSnapshot> _getUserData(uid) async {
    var _dta = users.doc(uid); //do we await / we shouldn't?
    var thing = await _dta.get();

    return Future.value(thing);
  }

  //Set User data
  void _initBadDogUser(dta) {
    _user.email = dta['email']; //object notation doesn't work...?
    _user.uid = dta['uid'];
    _user.username = dta['username'];
  }

  Future<BadDogUser> createBaddogUser(uid) async {
    //need get by uid or by username?
    var thing = await _getUserData(uid);

    _initBadDogUser(thing);

    print("RETURN BADDOG USER DATA ${_user.username}");

    return _user;
  }

//should probably just return for ease of use
//it's logging in - waiting is fine but needs suring up
  Future<void> _userAdded(uid) async {
    var _dta2 = await _getUserData(uid);
    _initBadDogUser(_dta2);
    notifyListeners(); //could just future return?
  }

  Future<void> setUser(username, email, uid) {
    // Call the user's CollectionReference to add a new user
    //if use set we could then use the uid to specify the user doc id?
    return users
        .doc(uid)
        .set(
          {
            'username': username,
            'email': email,
            'uid': uid,
          },
          SetOptions(merge: true),
        )
        .then((value) => {
              //assuming okay
              //we need to load the user
              print("User Added"),
              _userAdded(uid),
              //value.
            })
        .catchError((error) => print("Failed to add user: $error"));
  }
}

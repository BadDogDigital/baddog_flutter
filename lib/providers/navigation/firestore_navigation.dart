import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:baddog_flutter/models/navigation/navigation_model.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirestoreNavigation extends ChangeNotifier {
  //late MainNavigation
  //_currentNav; // = MainNavigation(id: id, buttons: buttons)();
  CollectionReference _navCollection =
      FirebaseFirestore.instance.collection('navigation');

  //Future<DocumentSnapshot> _getNavigationData(uid) async {
  Future<MainNavigation> getNavigationData({id}) async {
    var dta = await _navCollection
        .where('id', isEqualTo: id) //omit for get all
        .limit(1)
        .get();

    var doc = dta.docs[0]; //a bit ugly

    //if problems??
    return MainNavigation(id: doc["id"], buttons: doc["buttons"]);

    /*.then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["text"]);
        //create _currentNav
        notifyListeners();
        return MainNavigation(id: doc["id"], buttons: doc["buttons"]);
      });
      return MainNavigation(id: 'Error', buttons: []);
    });*/
    //return Future.value(thing);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:baddog_flutter/models/gridview/gridview_model.dart';

class FirestoreGridView extends ChangeNotifier {
  //late MainNavigation
  //_currentNav; // = MainNavigation(id: id, buttons: buttons)();
  CollectionReference _viewCollection =
      FirebaseFirestore.instance.collection('gridview');

  //Future<DocumentSnapshot> _getNavigationData(uid) async {
  //by id
  Future<GridViewModel> getGridViewData({id}) async {
    var dta = await _viewCollection
        .where('id', isEqualTo: id) //omit for get all
        .limit(1)
        .get();

    var doc = dta.docs[0]; //a bit ugly
    //id: doc["id"], gridItems: doc["items"]
    //doc.
    return GridViewModel(id: doc['id'], gridItems: doc['items']);
  }

  Future<DocumentSnapshot> _getData(uid) async {
    var _dta = _viewCollection.doc(uid); //do we await / we shouldn't?
    var thing = await _dta.get();

    return Future.value(thing);
  }

  Future<GridViewModel> getGridViewDataByDocId({id}) async {
    var dta = await _getData(id);

    var doc = dta; //a bit ugly

    return GridViewModel(id: doc['id'], gridItems: doc['items']);
  }
}

import 'package:flutter/foundation.dart';

//We probably need more information
//Or a second model perhaps for displaying info

class GridNavModel extends ChangeNotifier {
  int numOfItems;
  int index;

  ///_currentIndex should be 0 or input
  int _currentIndex;

  int get currentIndex => _currentIndex;
  set currentIndex(currentIndex) {
    _currentIndex = currentIndex;
    notifyListeners();
  }

  GridNavModel({
    required this.numOfItems,
    this.index = 0,
  }) : _currentIndex = index;
}

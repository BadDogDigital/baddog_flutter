import 'package:flutter/foundation.dart';

//We probably need more information

//Or a second model perhaps for displaying info

class FooterNavService extends ChangeNotifier {
  int numOfItems;
  int index;

  ///_currentIndex should be 0 or input
  int _currentIndex;

  //initialise with a json object

  int get currentIndex => _currentIndex;
  set currentIndex(currentIndex) {
    _currentIndex = currentIndex;
    notifyListeners();
  }

  FooterNavService({
    required this.numOfItems,
    this.index = 0,
  }) : _currentIndex = index;
}

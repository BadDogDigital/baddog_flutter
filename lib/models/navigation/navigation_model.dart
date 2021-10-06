class NavButton {
  String text;
  String? url;
  String? sub;
  NavButton({required this.text, required this.url, required this.sub});
}

class MainNavigation {
  String id;
  List buttons; //required or no?
  // how I say not required and use default [] ?
  //null check == []?
  MainNavigation({required this.id, required this.buttons});
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:baddog_flutter/providers/footer_nav/footer_nav_service.dart';

GetIt sl = GetIt.instance;

class MainFooter extends StatefulWidget {
  const MainFooter({
    Key? key,
  }) : super(key: key);

  @override
  _MainFooterState createState() => _MainFooterState();
}

class _MainFooterState extends State<MainFooter> {
  int _selectedIndex = 0;

  _navigate(int index) {
    _selectedIndex = index;
    print("SelectedIndex $_selectedIndex");
    sl<FooterNavService>().currentIndex = _selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: _navigate,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.black,
          ),
          label: 'Hubbub',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_box,
            color: Colors.black,
          ),
          label: 'Account',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.find_in_page,
            color: Colors.black,
          ),
          label: 'Find Pages',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_search,
            color: Colors.black,
          ),
          label: 'User Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.create,
            color: Colors.black,
          ),
          label: 'Create',
        ),
      ],
    );
  }
}

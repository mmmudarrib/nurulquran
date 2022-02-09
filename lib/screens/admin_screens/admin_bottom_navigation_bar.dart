import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nurulquran/providers/main_bottom_nav_bar_provider.dart';
import 'package:provider/provider.dart';

class AdminBottomNavigationBar extends StatelessWidget {
  const AdminBottomNavigationBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AdminBottomNavBarProvider _navBar =
        Provider.of<AdminBottomNavBarProvider>(context);
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedIconTheme: Theme.of(context).iconTheme,
      selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
      selectedItemColor: Theme.of(context).primaryColor,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      unselectedItemColor: Colors.grey,
      currentIndex: _navBar.currentTap,
      onTap: (int index) => _navBar.onTabTapped(index),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.book),
          label: 'Courses',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money_outlined),
          label: 'Payments',
        ),
      ],
    );
  }
}

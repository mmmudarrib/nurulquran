import 'package:flutter/material.dart';
import 'package:nurulquran/database/auth_methods.dart';
import 'package:nurulquran/providers/main_bottom_nav_bar_provider.dart';
import 'package:nurulquran/screens/admin_screens/admin_bottom_navigation_bar.dart';
import 'package:nurulquran/screens/admin_screens/pages/courses_dashboard.dart';
import 'package:nurulquran/screens/auth/login_screen.dart';
import 'package:nurulquran/utilities/custom_image.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);
  static const List<Widget> _pages = <Widget>[
    CoursesDashboard(),
    Text("Payments"),
  ];

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex =
        Provider.of<AdminBottomNavBarProvider>(context).currentTap;
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          width: 20,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Image.asset(CustomImages.logo),
          ),
        ),
        title: const Text("Nur ul Quran Admin Panel "),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              AuthMethods().signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: AdminDashboard._pages[_currentIndex],
      bottomNavigationBar: const AdminBottomNavigationBar(),
    );
  }
}

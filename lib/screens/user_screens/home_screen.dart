import 'package:flutter/material.dart';
import 'package:nurulquran/database/auth_methods.dart';
import 'package:nurulquran/database/user_api.dart';
import 'package:nurulquran/models/app_user.dart';
import 'package:nurulquran/providers/admin_bottom_nav_bar_provider.dart';
import 'package:nurulquran/screens/auth/login_screen.dart';
import 'package:nurulquran/screens/user_screens/pages/courses.dart';
import 'package:nurulquran/services/user_local_data.dart';
import 'package:nurulquran/utilities/custom_image.dart';
import 'package:provider/provider.dart';
import 'main_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/MainScreen';
  static const List<Widget> _pages = <Widget>[
    Courses(),
    Text("Profile"),
  ];

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _init() async {
    final AppUser appUser = await UserAPI().getInfo(uid: UserLocalData.getUID);
    UserLocalData().storeAppUserData(appUser: appUser);
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    int _currentIndex =
        Provider.of<MainBottomNavBarProvider>(context).currentTap;
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
        title: const Text("Nur ul Quran LMS"),
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
      body: HomeScreen._pages[_currentIndex],
      bottomNavigationBar: const MainBottomNavigationBar(),
    );
  }
}

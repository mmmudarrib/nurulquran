import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nurulquran/providers/admin_bottom_nav_bar_provider.dart';
import 'package:nurulquran/providers/course_provider.dart';
import 'package:nurulquran/providers/main_bottom_nav_bar_provider.dart';
import 'package:nurulquran/screens/admin_screens/admin_dashboard.dart';
import 'package:nurulquran/screens/user_screens/home_screen.dart';
import 'package:nurulquran/services/user_local_data.dart';
import 'package:provider/provider.dart';
import 'screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserLocalData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const Color _primary = Color(0xFF3A5899);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainBottomNavBarProvider>(
          create: (BuildContext context) => MainBottomNavBarProvider(),
        ),
        ChangeNotifierProvider<AdminBottomNavBarProvider>(
          create: (BuildContext context) => AdminBottomNavBarProvider(),
        ),
        ChangeNotifierProvider<CourseProvider>(
          create: (BuildContext context) => CourseProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'NurUlQuranLMS',
        theme: ThemeData(
          colorScheme: const ColorScheme(
            primary: _primary,
            primaryVariant: _primary,
            secondary: Colors.grey,
            secondaryVariant: Colors.white,
            surface: Colors.white,
            background: Colors.white,
            error: Colors.red,
            onPrimary: _primary,
            onSecondary: _primary,
            onSurface: Colors.white,
            onBackground: Colors.white,
            onError: Colors.redAccent,
            brightness: Brightness.light,
          ),
          primaryColor: _primary,
          iconTheme: const IconThemeData(color: _primary),
          splashColor: Colors.blue[300],
        ),
        home: getbody(),
      ),
    );
  }

  getbody() {
    if (UserLocalData.getUID.isEmpty) {
      return const LoginScreen();
    } else {
      if (UserLocalData.getIsAdmin) {
        return const AdminDashboard();
      } else {
        return const HomeScreen();
      }
    }
  }
}

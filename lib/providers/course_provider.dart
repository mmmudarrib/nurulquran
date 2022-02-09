import 'package:flutter/cupertino.dart';
import 'package:nurulquran/models/course.dart';

class CourseProvider extends ChangeNotifier {
  Course? _currentCourse;
  void onTabTapped(Course course) {
    _currentCourse = course;
    notifyListeners();
  }

  Course? get currentCourse => _currentCourse;
}

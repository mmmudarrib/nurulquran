import 'package:flutter/material.dart';
import 'package:nurulquran/models/course.dart';
import 'package:nurulquran/utilities/utilities.dart';
import 'package:nurulquran/widgets/course_card.dart';

import 'course_enrolled.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(Utilities.padding),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  "Courses".toUpperCase(),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 10),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enrolled Courses".toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.9,
                child: CourseCard(onTap: (Course course) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => CourseContent(
                        course: course,
                      ),
                    ),
                  );
                }),
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Available Courses".toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.9,
                child: CourseCard(onTap: (Course course) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => CourseContent(
                        course: course,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

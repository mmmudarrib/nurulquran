import 'package:flutter/material.dart';
import 'package:nurulquran/models/course.dart';
import 'package:nurulquran/providers/course_provider.dart';
import 'package:nurulquran/screens/admin_screens/add_course.dart';
import 'package:nurulquran/screens/admin_screens/course_enrolled_admin.dart';
import 'package:nurulquran/widgets/course_card.dart';
import 'package:nurulquran/widgets/custom_text_button.dart';
import 'package:nurulquran/widgets/custom_textformfield.dart';
import 'package:provider/provider.dart';

class CoursesDashboard extends StatefulWidget {
  const CoursesDashboard({Key? key}) : super(key: key);

  @override
  _CoursesDashboardState createState() => _CoursesDashboardState();
}

class _CoursesDashboardState extends State<CoursesDashboard> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CourseProvider _provider = Provider.of<CourseProvider>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 15, 8, 8),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "All Courses".toUpperCase(),
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 10),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          CustomTextButton(
            text: "Add Course",
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCourse(),
                ),
              )
            },
            hollowButton: false,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
            controller: searchcontroller,
            hint: "Course Name",
            title: "Search Course",
            autoFocus: false,
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: CourseCard(
                vertical: true,
                onTap: (Course course) {
                  _provider.onTabTapped(course);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const CourseContentAdmin(),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

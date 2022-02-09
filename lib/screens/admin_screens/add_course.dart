import 'package:flutter/material.dart';
import 'package:nurulquran/database/course_api.dart';
import 'package:nurulquran/models/course.dart';
import 'package:nurulquran/providers/main_bottom_nav_bar_provider.dart';
import 'package:nurulquran/screens/admin_screens/admin_dashboard.dart';
import 'package:nurulquran/utilities/custom_validator.dart';
import 'package:nurulquran/widgets/circular_icon_button.dart';
import 'package:nurulquran/widgets/custom_textformfield.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key}) : super(key: key);

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController cpController = TextEditingController();
  bool loading = false;
  String? type;
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Course',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 8.0),
              child: Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    CustomTextFormField(
                      title: 'Course Name',
                      controller: courseNameController,
                      hint: 'Course Name',
                      validator: (String? value) =>
                          CustomValidator.isEmpty(value),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      title: 'Cover Photo Link ',
                      controller: cpController,
                      hint: 'https://abc.com/abc.png',
                      validator: (String? value) =>
                          CustomValidator.isEmpty(value),
                      keyboardType: TextInputType.url,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        ' Course Type:',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    ),
                    /* DropdownButton<String>(
                      menuMaxHeight: MediaQuery.of(context).size.height * 0.7,
                      underline: const SizedBox(),
                      hint: const Text("Type"),
                      value: type,
                      items: const [
                        DropdownMenuItem<String>(
                          value: "Live",
                          child: Text('Live Course'),
                        ),
                        DropdownMenuItem<String>(
                          value: "SelfPaced",
                          child: Text('SelfPaced'),
                        ),
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          type = value!;
                        });
                      },
                    ),*/
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CircularIconButton(onTap: () async {
                      if (_key.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        Course course = Course(
                            coverPhoto: courseNameController.text,
                            name: courseNameController.text);
                        CourseAPI().addCourse(course);

                        setState(() {
                          loading = false;
                        });
                        AdminBottomNavBarProvider().onTabTapped(0);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminDashboard(),
                          ),
                        );
                      }
                    }),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}

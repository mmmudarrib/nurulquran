import 'package:flutter/material.dart';
import 'package:nurulquran/database/course_api.dart';
import 'package:nurulquran/models/course.dart';
import 'package:nurulquran/providers/course_provider.dart';
import 'package:nurulquran/providers/main_bottom_nav_bar_provider.dart';
import 'package:nurulquran/screens/admin_screens/course_enrolled_admin.dart';
import 'package:nurulquran/utilities/custom_validator.dart';
import 'package:nurulquran/widgets/circular_icon_button.dart';
import 'package:nurulquran/widgets/custom_textformfield.dart';
import 'package:provider/provider.dart';

class AddLecture extends StatefulWidget {
  const AddLecture({Key? key}) : super(key: key);

  @override
  _AddLectureState createState() => _AddLectureState();
}

class _AddLectureState extends State<AddLecture> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController videoTitleController = TextEditingController();
  final TextEditingController videolinkController = TextEditingController();
  final TextEditingController thumbnaillinkController = TextEditingController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Course? course = Provider.of<CourseProvider>(context).currentCourse;
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
            'Add Lecture',
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
                      title: 'Video Title',
                      controller: videoTitleController,
                      hint: 'Video Title',
                      validator: (String? value) =>
                          CustomValidator.isEmpty(value),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      title: 'Video Link ',
                      controller: videolinkController,
                      hint: 'https://abc.com/abc.mp4',
                      validator: (String? value) =>
                          CustomValidator.isEmpty(value),
                      keyboardType: TextInputType.url,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      title: 'Thumbnail Link ',
                      controller: thumbnaillinkController,
                      hint: 'https://abc.com/abc.png',
                      validator: (String? value) =>
                          CustomValidator.isEmpty(value),
                      keyboardType: TextInputType.url,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CircularIconButton(onTap: () async {
                      if (_key.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        Videos video = Videos(
                            title: videoTitleController.text,
                            link: videolinkController.text,
                            coverPhoto: thumbnaillinkController.text);
                        CourseAPI().addLecture(video, course!);

                        setState(() {
                          loading = false;
                        });
                        AdminBottomNavBarProvider().onTabTapped(0);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CourseContentAdmin(),
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

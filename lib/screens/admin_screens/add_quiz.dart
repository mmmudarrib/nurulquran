import 'package:flutter/material.dart';
import 'package:nurulquran/database/course_api.dart';
import 'package:nurulquran/models/course.dart';
import 'package:nurulquran/models/quiz.dart';
import 'package:nurulquran/providers/course_provider.dart';
import 'package:nurulquran/screens/admin_screens/add_question.dart';
import 'package:nurulquran/utilities/custom_validator.dart';
import 'package:nurulquran/widgets/circular_icon_button.dart';
import 'package:nurulquran/widgets/custom_textformfield.dart';
import 'package:nurulquran/widgets/custom_toast.dart';
import 'package:provider/provider.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({Key? key}) : super(key: key);

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController quizTitleController = TextEditingController();
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
            'Add Quiz',
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
                child: Column(children: <Widget>[
                  CustomTextFormField(
                    title: 'Quiz Title',
                    controller: quizTitleController,
                    hint: 'Quiz Title',
                    validator: (String? value) =>
                        CustomValidator.isEmpty(value),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CircularIconButton(
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        Quiz quiz = Quiz(title: quizTitleController.text);
                        CourseAPI().addQuizData(quiz, course!);
                        CustomToast.successToast(message: "Quiz Added");
                        setState(() {
                          loading = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddQuestion(quiz: quiz)));
                      }
                    },
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
    }
  }
}

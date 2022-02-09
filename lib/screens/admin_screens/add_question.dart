import 'package:flutter/material.dart';
import 'package:nurulquran/database/course_api.dart';
import 'package:nurulquran/models/course.dart';
import 'package:nurulquran/models/quiz.dart';
import 'package:nurulquran/providers/course_provider.dart';
import 'package:nurulquran/screens/admin_screens/course_enrolled_admin.dart';
import 'package:nurulquran/utilities/custom_validator.dart';
import 'package:nurulquran/widgets/custom_text_button.dart';
import 'package:nurulquran/widgets/custom_textformfield.dart';
import 'package:provider/provider.dart';

class AddQuestion extends StatefulWidget {
  final Quiz quiz;
  const AddQuestion({Key? key, required this.quiz}) : super(key: key);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  bool isLoading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController option1 = TextEditingController();
  final TextEditingController option2 = TextEditingController();
  final TextEditingController option3 = TextEditingController();
  final TextEditingController option4 = TextEditingController();
  int correct = 1;
  Course? course;
  @override
  Widget build(BuildContext context) {
    course = Provider.of<CourseProvider>(context).currentCourse;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black54,
        ),
        title: const Text("Add Question"),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _key,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: questionController,
                        title: "Enter Question",
                        hint: "Enter Question",
                        validator: (String? value) =>
                            CustomValidator.isEmpty(value),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        controller: option1,
                        title: "Option 1",
                        hint: "Option 1",
                        validator: (String? value) =>
                            CustomValidator.isEmpty(value),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextFormField(
                        controller: option2,
                        title: "Option 2",
                        hint: "Option 2",
                        validator: (String? value) =>
                            CustomValidator.isEmpty(value),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextFormField(
                        controller: option3,
                        title: "Option 3",
                        hint: "Option 3",
                        validator: (String? value) =>
                            CustomValidator.isEmpty(value),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextFormField(
                        controller: option4,
                        title: "Option 4",
                        hint: "Option 4",
                        validator: (String? value) =>
                            CustomValidator.isEmpty(value),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextButton(
                        text: "Add Question",
                        onTap: () {
                          addquestiondata();
                        },
                        hollowButton: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextButton(
                        text: "Done",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CourseContentAdmin()));
                        },
                        hollowButton: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void addquestiondata() {
    if (_key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      Answers op1 = Answers(option: option1.text, correct: correct == 1);
      Answers op2 = Answers(option: option2.text, correct: correct == 2);
      Answers op3 = Answers(option: option3.text, correct: correct == 3);
      Answers op4 = Answers(option: option4.text, correct: correct == 4);
      List<Answers> answers = <Answers>[];
      answers.addAll([op1, op2, op3, op4]);
      Question question =
          Question(statment: questionController.text, answers: answers);
      CourseAPI().addQuestionData(widget.quiz, course!, question);
      questionController.clear();
      option1.clear();
      option2.clear();
      option3.clear();
      option4.clear();
      setState(() {
        isLoading = false;
      });
    }
  }
}

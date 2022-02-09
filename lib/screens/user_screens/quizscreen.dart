import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nurulquran/database/course_api.dart';
import 'package:nurulquran/models/course.dart';
import 'package:nurulquran/models/quiz.dart';
import 'package:nurulquran/screens/user_screens/pages/results.dart';
import 'package:nurulquran/utilities/custom_image.dart';
import 'package:nurulquran/widgets/custom_text_button.dart';
import 'package:nurulquran/widgets/quiz_play_widgets.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;
  final Course course;
  const QuizScreen({Key? key, required this.quiz, required this.course})
      : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int total = 0;

class _QuizScreenState extends State<QuizScreen> {
  bool isLoading = true;
  Stream? infoStream;
  QuerySnapshot<Map<String, dynamic>>? questionSnaphot;
  @override
  void initState() {
    CourseAPI().getQuestionData(widget.quiz, widget.course).then((value) {
      questionSnaphot = value;
      _notAttempted = questionSnaphot!.docs.length;
      _correct = 0;
      _incorrect = 0;
      infoStream ??=
          Stream<List<int>>.periodic(const Duration(milliseconds: 100), (x) {
        return [_correct, _incorrect];
      });
      isLoading = false;
      total = questionSnaphot!.docs.length;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBar(
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
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.quiz.title,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 10),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  questionSnaphot?.docs == null
                      ? const Center(
                          child: Text("No Data Report to Admin"),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(
                              thickness: 2.0,
                            );
                          },
                          itemCount: questionSnaphot!.docs.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return QuizPlayTile(
                              questionModel: Question.fromDoc(
                                  questionSnaphot!.docs[index]),
                              index: index,
                            );
                          }),
                  CustomTextButton(
                    text: "Submit",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Results(
                                    notattempted: _notAttempted,
                                    correct: _correct,
                                    incorrect: _incorrect,
                                    total: total,
                                  )));
                    },
                    hollowButton: false,
                  )
                ],
              ),
            ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final Question questionModel;
  final int index;

  // ignore: use_key_in_widget_constructors
  const QuizPlayTile({required this.questionModel, required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  @override
  void initState() {
    widget.questionModel.answers.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Q(${widget.index + 1}/$total) : ${widget.questionModel.statment}",
            style:
                TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct
              if (widget.questionModel.answers[0].correct) {
                setState(() {
                  optionSelected = widget.questionModel.answers[0].option;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.answers[0].option;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionTile(
            option: "A",
            answer: widget.questionModel.answers[0],
            optionSelected: optionSelected,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct
              if (widget.questionModel.answers[1].correct) {
                setState(() {
                  optionSelected = widget.questionModel.answers[1].option;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.answers[1].option;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionTile(
            option: "B",
            answer: widget.questionModel.answers[1],
            optionSelected: optionSelected,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct
              if (widget.questionModel.answers[2].correct) {
                setState(() {
                  optionSelected = widget.questionModel.answers[2].option;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.answers[2].option;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionTile(
            option: "C",
            answer: widget.questionModel.answers[2],
            optionSelected: optionSelected,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct
              if (widget.questionModel.answers[3].correct) {
                setState(() {
                  optionSelected = widget.questionModel.answers[3].option;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.answers[3].option;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionTile(
            option: "D",
            answer: widget.questionModel.answers[3],
            optionSelected: optionSelected,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

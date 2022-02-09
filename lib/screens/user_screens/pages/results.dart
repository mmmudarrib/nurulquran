import 'package:flutter/material.dart';
import 'package:nurulquran/screens/admin_screens/course_enrolled_admin.dart';
import 'package:nurulquran/widgets/custom_text_button.dart';

class Results extends StatefulWidget {
  final int total, correct, incorrect, notattempted;
  const Results(
      {Key? key,
      required this.incorrect,
      required this.total,
      required this.correct,
      required this.notattempted})
      : super(key: key);

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${widget.correct}/ ${widget.total}",
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "you answered ${widget.correct} answers correctly and ${widget.incorrect} answers incorrectly",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            CustomTextButton(
              text: "Go Home",
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CourseContentAdmin()));
              },
              hollowButton: false,
            ),
          ],
        ),
      ),
    );
  }
}

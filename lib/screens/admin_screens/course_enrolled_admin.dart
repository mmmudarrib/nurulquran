import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:nurulquran/database/course_api.dart';
import 'package:nurulquran/models/course.dart';
import 'package:nurulquran/models/quiz.dart';
import 'package:nurulquran/providers/course_provider.dart';
import 'package:nurulquran/screens/admin_screens/add_lecture.dart';
import 'package:nurulquran/screens/admin_screens/add_quiz.dart';
import 'package:nurulquran/screens/user_screens/pages/video_player.dart';
import 'package:nurulquran/screens/user_screens/quizscreen.dart';
import 'package:nurulquran/utilities/custom_image.dart';
import 'package:nurulquran/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class CourseContentAdmin extends StatefulWidget {
  const CourseContentAdmin({Key? key}) : super(key: key);

  @override
  _CourseContentAdminState createState() => _CourseContentAdminState();
}

class _CourseContentAdminState extends State<CourseContentAdmin> {
  Course? course;
  TabBar get _tabBar => TabBar(
        labelColor: Theme.of(context).primaryColor,
        tabs: const [
          Tab(
            icon: Icon(Icons.video_camera_back_outlined),
            text: "Videos",
          ),
          Tab(
            icon: Icon(Icons.question_answer),
            text: "Quiz",
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    course = Provider.of<CourseProvider>(context).currentCourse;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(course!.name),
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: ColoredBox(
              color: Colors.white,
              child: _tabBar,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            listvideos(),
            listquiz(),
          ],
        ),
      ),
    );
  }

  Widget listvideos() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CustomTextButton(
          text: "Add Lecture",
          onTap: () => {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const AddLecture()))
          },
          hollowButton: false,
        ),
        const SizedBox(
          height: 40,
        ),
        ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 15,
            );
          },
          itemCount: course!.videos!.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: SizedBox(
                height: 80,
                width: 80,
                child: ExtendedImage.network(CustomImages.domeURL),
              ),
              title: Text("Lecture " + (index + 1).toString()),
              trailing: IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => CourseVideoPlayer(
                        video: course!.videos![index],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget listquiz() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CustomTextButton(
          text: "Add Quiz",
          onTap: () => {
            {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AddQuiz()))
            },
          },
          hollowButton: false,
        ),
        const SizedBox(
          height: 40,
        ),
        FutureBuilder<List<Quiz>>(
            future: CourseAPI().allQuizes(course!),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: Text("No Quiz Added Yet"),
                );
              } else {
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 15,
                    );
                  },
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: IconButton(
                        icon: Icon(
                          Icons.question_answer,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {},
                      ),
                      title: Text(snapshot.data![index].title),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) => QuizScreen(
                                quiz: snapshot.data![index],
                                course: course!,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            }),
      ],
    );
  }
}

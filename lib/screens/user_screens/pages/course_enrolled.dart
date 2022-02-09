import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:nurulquran/models/course.dart';
import 'package:nurulquran/screens/user_screens/pages/video_player.dart';
import 'package:nurulquran/utilities/custom_image.dart';

class CourseContent extends StatefulWidget {
  final Course course;
  const CourseContent({Key? key, required this.course}) : super(key: key);

  @override
  _CourseContentState createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.course.name),
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
          ],
        ),
      ),
    );
  }

  Widget listvideos() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 15,
        );
      },
      itemCount: widget.course.videos!.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: SizedBox(
            height: 80,
            width: 80,
            child: ExtendedImage.network(CustomImages.domeURL),
          ),
          onTap: () {},
          title: Text("Lecture " + (index + 1).toString()),
          trailing: IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => CourseVideoPlayer(
                    video: widget.course.videos![index],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

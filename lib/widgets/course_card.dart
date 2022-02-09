import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:nurulquran/database/course_api.dart';
import 'package:nurulquran/models/course.dart';

class CourseCard extends StatefulWidget {
  final String? uid;
  final bool vertical;
  final Function onTap;
  const CourseCard({
    Key? key,
    required this.onTap,
    this.uid = "",
    this.vertical = false,
  }) : super(key: key);

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    String? mediaUrl = "";
    return FutureBuilder<List<Course>>(
        future: getevents(),
        builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator.adaptive(),
              );
            default:
              if ((snapshot.hasError)) {
                return _errorWidget();
              } else {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return Column(children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: widget.vertical
                                ? Axis.vertical
                                : Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (snapshot.data![index].coverPhoto == "") {
                                mediaUrl =
                                    "https://i.ibb.co/qmJq2kQ/fotografu-wrhh-CD6jpj8-unsplash.jpg";
                              } else {
                                mediaUrl = snapshot.data![index].coverPhoto;
                              }
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: 250,
                                child: InkWell(
                                  onTap: () =>
                                      widget.onTap(snapshot.data![index]),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        width: 250,
                                        child: Card(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 5,
                                          margin: const EdgeInsets.all(5),
                                          child: ExtendedImage.network(
                                            mediaUrl!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        snapshot.data![index].name,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      widget.vertical
                                          ? Column(
                                              children: [
                                                Text(
                                                  "Videos : " +
                                                      snapshot.data![index]
                                                          .videos!.length
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(
                                                  width: 40,
                                                ),
                                                Text(
                                                  "Quizes : 0",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Videos : " +
                                                      snapshot.data![index]
                                                          .videos!.length
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(
                                                  width: 40,
                                                ),
                                                Text(
                                                  "Quizes : 0",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ]);
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "No Courses Added yet",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 14),
                        ),
                      ],
                    );
                  }
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "No Courses Added yet",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 14),
                      ),
                    ],
                  );
                }
              }
          }
        });
  }

  SizedBox _errorWidget() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Column(
          children: const <Widget>[
            Icon(Icons.info, color: Colors.grey),
            Text(
              'Facing some issues',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Course>> getevents() async {
    return await CourseAPI().allCourses();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nurulquran/models/course.dart';
import 'package:nurulquran/models/quiz.dart';
import 'package:nurulquran/widgets/custom_toast.dart';

class CourseAPI {
  static const String _collection = 'courses';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<List<Course>> allCourses() async {
    List<Course> _courses = <Course>[];
    final QuerySnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).get();
    for (DocumentSnapshot<Map<String, dynamic>> element in doc.docs) {
      final Course _temp = Course.fromDoc((element));
      _courses.add(_temp);
    }
    return _courses;
  }

  Future<List<Quiz>> allQuizes(Course course) async {
    List<Quiz> _courses = <Quiz>[];
    final QuerySnapshot<Map<String, dynamic>> doc = await _instance
        .collection(_collection)
        .doc(course.id)
        .collection("Quiz")
        .get();
    for (DocumentSnapshot<Map<String, dynamic>> element in doc.docs) {
      final Quiz _temp = Quiz.fromDoc((element));
      _courses.add(_temp);
    }
    return _courses;
  }

  Future<bool> addLecture(Videos video, Course course) async {
    List<Videos>? videos = course.videos;
    videos?.add(video);
    List<Map<String, dynamic>>? videosMap = <Map<String, dynamic>>[];
    videos?.forEach((element) {
      videosMap.add(element.toMap());
    });
    await _instance
        .collection(_collection)
        .doc(course.id)
        .update(<String, dynamic>{'videos': videosMap}).catchError((Object e) {
      CustomToast.errorToast(message: e.toString());
      // ignore: invalid_return_type_for_catch_error
      return false;
    });
    return true;
  }

  Future<bool> addCourse(Course course) async {
    await _instance
        .collection(_collection)
        .doc(course.id)
        .set(course.toMap())
        .catchError((Object e) {
      CustomToast.errorToast(message: e.toString());
      // ignore: invalid_return_type_for_catch_error
      return false;
    });
    return true;
  }

  Future<void> addQuizData(Quiz quiz, Course course) async {
    await _instance
        .collection(_collection)
        .doc(course.id)
        .collection("Quiz")
        .doc(quiz.id)
        .set(quiz.toMap())
        .catchError((e) {
      CustomToast.errorToast(message: e);
    });
  }

  Future<void> addQuestionData(
      Quiz quiz, Course course, Question question) async {
    await _instance
        .collection(_collection)
        .doc(course.id)
        .collection("Quiz")
        .doc(quiz.id)
        .collection("QNA")
        .add(question.toMap())
        .catchError((e) {
      CustomToast.errorToast(message: e);
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getQuizData(Course course) {
    return _instance
        .collection(_collection)
        .doc(course.id)
        .collection("Quiz")
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getQuestionData(
      Quiz quiz, Course course) async {
    return await _instance
        .collection(_collection)
        .doc(course.id)
        .collection("Quiz")
        .doc(quiz.id)
        .collection("QNA")
        .get();
  }
}

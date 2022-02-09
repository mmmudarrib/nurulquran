import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Quiz {
  String? id;
  String title;
  Quiz({required this.title, this.id}) {
    id ??= const Uuid().v4().toString();
  }
  factory Quiz.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Quiz(
      title: doc.data()!['title'] ?? '',
      id: doc.data()!['id'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'id': id,
    };
  }
}

class Question {
  String statment;
  bool answered = false;
  List<Answers> answers;
  Question({required this.statment, required this.answers});
  factory Question.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    List<Answers> v = <Answers>[];
    doc.data()!['answers'].forEach((dynamic e) {
      v.add(Answers.fromJson(e));
    });
    return Question(
      statment: doc.data()!['statment'] ?? '',
      answers: v,
    );
  }

  Map<String, dynamic> toMap() {
    List<dynamic> v = <Map<String, dynamic>>[];
    v = answers.map((v) => v.toJson()).toList();
    return <String, dynamic>{
      'statment': statment,
      'answers': v,
    };
  }
}

class Answers {
  late String option;
  late bool correct;

  Answers({required this.option, required this.correct});

  Answers.fromJson(Map<String, dynamic> json) {
    option = json['option'];
    correct = json['correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option'] = option;
    data['correct'] = correct;
    return data;
  }
}

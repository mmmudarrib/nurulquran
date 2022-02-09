import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Course {
  String name;
  List<Videos>? videos = <Videos>[];
  String coverPhoto;
  String? id;

  Course({
    required this.name,
    this.videos,
    required this.coverPhoto,
    this.id,
  }) {
    id ??= const Uuid().v4().toString();
    videos ??= <Videos>[];
  }

  factory Course.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    List<Videos> v = <Videos>[];
    doc.data()!['videos'].forEach((dynamic e) {
      v.add(Videos.fromMap(e));
    });
    return Course(
      name: doc.data()!['name'] ?? '',
      coverPhoto: doc.data()!['cover_photo'] ?? '',
      id: doc.data()!['id'] ?? '',
      videos: v,
    );
  }

  Map<String, dynamic> toMap() {
    List<dynamic> v = <Map<String, dynamic>>[];
    if (videos != null) {
      v = videos!.map((v) => v.toMap()).toList();
    }
    return <String, dynamic>{
      'name': name,
      'id': id,
      'videos': v,
      'cover_photo': coverPhoto,
    };
  }
}

class Videos {
  String? dateAdded;
  String link;
  String coverPhoto;
  String title;

  Videos(
      {this.dateAdded,
      required this.link,
      required this.coverPhoto,
      required this.title}) {
    dateAdded ??= DateTime.now().toString();
  }

  factory Videos.fromMap(Map<String, dynamic>? data) {
    return Videos(
      dateAdded: data!['date_added'] ?? '',
      link: data['link'] ?? '',
      coverPhoto: data['cover_photo'] ?? '',
      title: data['title'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date_added': dateAdded,
      'link': link,
      'cover_photo': coverPhoto,
      'title': title,
    };
  }
}

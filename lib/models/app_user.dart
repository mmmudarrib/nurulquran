import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  AppUser({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    this.isAdmin,
    this.timestamp,
    this.courses,
  });
  final String uid;
  final String name;
  final bool? isAdmin;
  final String phoneNumber;
  final String? timestamp;
  final List<String>? courses;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name.trim(),
      'phone': phoneNumber,
      'isAdmin': isAdmin ?? false,
      'timestamp': timestamp ?? DateTime.now(),
      'courses': courses ?? <String>[],
    };
  }

  // ignore: sort_constructors_first
  factory AppUser.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return AppUser(
      uid: doc.data()!['uid'],
      phoneNumber: doc.data()!['phone'],
      name: doc.data()!['name'],
      isAdmin: doc.data()!['isAdmin'] ?? false,
      timestamp: doc.data()!['timestamp'].toString(),
      courses: List<String>.from(doc.data()!['courses']),
    );
  }
}

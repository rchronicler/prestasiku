import 'package:cloud_firestore/cloud_firestore.dart';

class Competition {
  final String docId;
  final String imageUrl;
  final String title;
  final Timestamp deadline;
  final Timestamp event;
  final bool hsStudent;
  final bool collegeStudent;
  final bool isFree;

  Competition({
    required this.docId,
    required this.imageUrl,
    required this.title,
    required this.deadline,
    required this.event,
    required this.isFree,
    required this.hsStudent,
    required this.collegeStudent,
  });

  factory Competition.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Competition(
      docId: snapshot.reference.id,
      imageUrl: snapshot.data()!['imageUrl'],
      title: snapshot.data()!['title'],
      deadline: snapshot.data()!['deadline'],
      event: snapshot.data()!['event'],
      hsStudent: snapshot.data()!['hsStudent'],
      collegeStudent: snapshot.data()!['collegeStudent'],
      isFree: snapshot.data()!['isFree'],
    );
  }
}
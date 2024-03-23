import 'package:cloud_firestore/cloud_firestore.dart';

class Detail {
  final String title;
  final String about;
  final String location;
  final List<String> requirements;

  Detail({required this.title, required this.about, required this.location, required this.requirements});

  factory Detail.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    return Detail(
      title: snapshot['title'] ?? '',
      about: snapshot['about'] ?? '',
      location: snapshot['location'] ?? '',
      requirements: List<String>.from(snapshot['requirements'] ?? []),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/detail_model.dart';

// accept docId as a parameter
final detailProvider = StreamProvider.family((ref, docId) {
 final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('competitions');

  return collection.doc(docId as String?).snapshots().map((snapshot) => Detail.fromSnapshot(snapshot));
});
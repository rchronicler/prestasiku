import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../models/competition.dart';

final competitionProvider = StreamProvider((ref) {
  final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('competitions');

  return collection.snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Competition.fromSnapshot(doc)).toList());
});

final uploadImageProvider = Provider.autoDispose((ref) {
  final storage = FirebaseStorage.instance;

  Future<String> uploadImage(String filePath) async {
    final reference = storage.ref().child('competition_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final task = await reference.putFile(File(filePath));
    final url = await task.ref.getDownloadURL();
    return url;
  }

  return uploadImage;
});

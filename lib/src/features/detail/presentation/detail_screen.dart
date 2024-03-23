import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/detail_model.dart';
import '../providers/detail_provider.dart';

class DetailScreen extends ConsumerWidget {
  final String docId;

  const DetailScreen({Key? key, required this.docId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(detailProvider(docId));
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: detail.when(
            data: (data) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Judul"),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data.title)),
                  // rounded
                ),
                SizedBox(height: 10),
                Text("Deskripsi"),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data.about)),
                  // rounded
                ),
                SizedBox(height: 10),
                Text("Ketentuan"),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: data.requirements.map((r) => Text('• $r')).toList(),
                      ),
                  ),
                  // rounded
                ),
                SizedBox(height: 10),
                Text("Lokasi"),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data.location)),
                  // rounded
                ),
              ],
            ),
            loading: () => CircularProgressIndicator(),
            error: (error, stackTrace) => Text('Error: $error'),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteDataSource {
  Stream<QuerySnapshot> dataStream() {
    return FirebaseFirestore.instance
        .collection('records')
        .orderBy('date', descending: true)
        .snapshots();
  }

  Future<void> add({required String date, required String isTaken}) async {
    await FirebaseFirestore.instance.collection('records').add({
      "date": date,
      "isTaken": isTaken,
    });
  }
}

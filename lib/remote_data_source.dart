import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteDataSource {
  Stream<QuerySnapshot> dataStream() {
    return FirebaseFirestore.instance.collection('records').snapshots();
  }

  Future<void> add({required String date, required String isTaken}) {
    return FirebaseFirestore.instance.collection('records').add({
      "date": date,
      "isTaken": isTaken,
    });
  }
}

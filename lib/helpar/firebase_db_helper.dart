import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDBHelper
{
  FirebaseDBHelper._();
  static final FirebaseDBHelper firebaseDBHelper = FirebaseDBHelper._();

  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> insertBook({required Map<String, dynamic> data}) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
    await db.collection("count").doc("author - count").get();

    int count = documentSnapshot.data()!['counts'];
    int id = documentSnapshot.data()!['id'];

    await db.collection("Author").doc("${++id}").set(data);

    await db.collection("count").doc("author - count").update({"id": id});

    await db
        .collection("count")
        .doc("author - count")
        .update({"counts": ++count});
  }

  Future<void> deleteBook({required String id}) async {
    await db.collection("Author").doc(id).delete();

    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
    await db.collection("count").doc("author - count").get();

    int count = documentSnapshot.data()!['counts'];

    await db
        .collection("count")
        .doc("author - count")
        .update({"counts": --count});
  }

  Future<void> updateBook({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    await db.collection("Author").doc(id).update(data);
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> categoryGetData() {
    return FirebaseFirestore.instance
        .collection("category")
        .where("live", isEqualTo: true)
        .snapshots();
  }
}

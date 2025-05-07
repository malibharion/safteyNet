import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saftey_net/Model/communityModel.dart';

class CommunityProvider with ChangeNotifier {
  List<ComplaintModel> complaints = [];
  bool isLoading = true;

  Future<void> fetchComplaints() async {
    isLoading = true;
    notifyListeners();

    final snapshot = await FirebaseFirestore.instance
        .collection('complaints')
        .orderBy('timestamp', descending: true)
        .get();

    complaints =
        snapshot.docs.map((doc) => ComplaintModel.fromMap(doc.data())).toList();

    isLoading = false;
    notifyListeners();
  }
}

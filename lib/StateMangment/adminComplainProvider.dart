import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ComplaintManagerProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _complaints = [];
  List<Map<String, dynamic>> get complaints => _complaints;

  Future<void> fetchComplaints({String? status}) async {
    try {
      Query query = _firestore.collection('complaints');

      if (status != null) {
        query = query.where('status', isEqualTo: status);
      }

      QuerySnapshot snapshot = await query.get();

      _complaints = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          ...data,
        };
      }).toList();

      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching complaints: $e");
    }
  }

  Future<void> updateComplaintStatus(
      String complaintId, String newStatus) async {
    try {
      await _firestore.collection('complaints').doc(complaintId).update({
        'status': newStatus,
      });
      await fetchComplaints(); // Refresh list after update
    } catch (e) {
      debugPrint("Error updating complaint status: $e");
    }
  }

  void removeComplaintById(String complaintId) {
    _complaints.removeWhere((complaint) => complaint['id'] == complaintId);
    notifyListeners();
  }
}

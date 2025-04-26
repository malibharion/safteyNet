// screens/rejected_complaints_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saftey_net/Models/complaintsModel.dart';
import 'package:saftey_net/Models/model.dart';

class RejectedComplaintsScreen extends StatefulWidget {
  const RejectedComplaintsScreen({super.key});

  @override
  State<RejectedComplaintsScreen> createState() =>
      _RejectedComplaintsScreenState();
}

class _RejectedComplaintsScreenState extends State<RejectedComplaintsScreen> {
  List<Complaint> complaints = [];

  @override
  void initState() {
    super.initState();
    fetchComplaints();
  }

  Future<void> fetchComplaints() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('complaints')
        .where('status', isEqualTo: 'rejected')
        .get();

    setState(() {
      complaints = querySnapshot.docs
          .map((doc) => Complaint.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rejected Complaints')),
      body: ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          final complaint = complaints[index];
          return ListTile(
            title: Text(complaint.type),
            subtitle: Text(complaint.description),
          );
        },
      ),
    );
  }
}

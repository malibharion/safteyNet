// screens/solved_complaints_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saftey_net/Models/complaintsModel.dart';
import 'package:saftey_net/Models/model.dart';

class SolvedComplaintsScreen extends StatefulWidget {
  const SolvedComplaintsScreen({super.key});

  @override
  State<SolvedComplaintsScreen> createState() => _SolvedComplaintsScreenState();
}

class _SolvedComplaintsScreenState extends State<SolvedComplaintsScreen> {
  List<Complaint> complaints = [];

  @override
  void initState() {
    super.initState();
    fetchComplaints();
  }

  Future<void> fetchComplaints() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('complaints')
        .where('status', isEqualTo: 'solved')
        .get();

    setState(() {
      complaints = querySnapshot.docs
          .map((doc) =>
              Complaint.fromMap(doc.data(), doc.id)) // Pass the document ID
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solved Complaints')),
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

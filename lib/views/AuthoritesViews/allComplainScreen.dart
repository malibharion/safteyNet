// screens/all_complaints_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:saftey_net/Models/model.dart';

import 'package:saftey_net/views/AuthoritesViews/complainDetailScreen.dart'; // Import your details screen

class AllComplaintsScreen extends StatefulWidget {
  const AllComplaintsScreen({super.key});

  @override
  State<AllComplaintsScreen> createState() => _AllComplaintsScreenState();
}

class _AllComplaintsScreenState extends State<AllComplaintsScreen> {
  Stream<List<Complaint>> fetchComplaints() {
    return FirebaseFirestore.instance
        .collection('complaints')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Complaint.fromMap(data, doc.id);
      }).toList();
    });
  }

  void _deleteComplaint(String id) {
    FirebaseFirestore.instance
        .collection('complaints')
        .doc(id)
        .delete()
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complaint deleted')),
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting complaint: $e')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Complaints')),
      body: StreamBuilder<List<Complaint>>(
        stream: fetchComplaints(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final complaints = snapshot.data ?? [];

          if (complaints.isEmpty) {
            return const Center(child: Text('No complaints found.'));
          }

          return ListView.separated(
            itemCount: complaints.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final complaint = complaints[index];

              return ListTile(
                title: Text(complaint.type),
                subtitle: Text(complaint.description),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteComplaint(complaint.id),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ComplaintDetailsScreen(complaint: complaint),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

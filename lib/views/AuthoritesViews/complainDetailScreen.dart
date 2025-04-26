// screens/complaint_details_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saftey_net/Models/complaintsModel.dart';
import 'package:saftey_net/Models/model.dart';
import 'package:url_launcher/url_launcher.dart';

class ComplaintDetailsScreen extends StatelessWidget {
  final Complaint complaint;

  const ComplaintDetailsScreen({required this.complaint});
  void _openMap(String location) async {
    final Uri googleUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(location)}');
    try {
      if (await launchUrl(googleUrl, mode: LaunchMode.externalApplication)) {
        // URL launched successfully
      } else {
        throw 'Could not launch $googleUrl';
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Handle the error appropriately (e.g., show a snackbar)
    }
  }

  void _markAsSolved(Complaint complaint) {
    if (complaint.id.isNotEmpty) {
      // Check complaint.id instead of complaint.type
      FirebaseFirestore.instance
          .collection('complaints')
          .doc(complaint.id)
          .update({
        'status': 'solved',
      }).then((_) {
        print('Complaint marked as solved');
      }).catchError((e) {
        print('Error marking as solved: $e');
      });
    } else {
      print('Invalid complaint ID!');
    }
  }

  void _markAsRejected(Complaint complaint) {
    if (complaint.id.isNotEmpty) {
      // Check complaint.id instead of complaint.type
      FirebaseFirestore.instance
          .collection('complaints')
          .doc(complaint.id)
          .update({
        'status': 'rejected',
      }).then((_) {
        print('Complaint marked as solved');
      }).catchError((e) {
        print('Error marking as solved: $e');
      });
    } else {
      print('Invalid complaint ID!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${complaint.type}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Description: ${complaint.description}',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Location: ${complaint.location}',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Date: ${complaint.date.toLocal()}',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Urgent: ${complaint.isUrgent ? 'Yes' : 'No'}',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _markAsSolved(complaint);

                Navigator.pop(context);
              },
              child: const Text('Mark as Solved'),
            ),
            ElevatedButton(
              onPressed: () {
                _markAsRejected(complaint);
                Navigator.pop(context);
              },
              child: const Text('Reject Complaint'),
            ),
            ElevatedButton(
              onPressed: () {
                _openMap(complaint.location);
              },
              child: const Text('View Location on Map'),
            ),
          ],
        ),
      ),
    );
  }
}

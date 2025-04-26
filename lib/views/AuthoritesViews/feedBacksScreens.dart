// screens/feedback_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting date

class FeedbackScreenAuthorirties extends StatelessWidget {
  const FeedbackScreenAuthorirties({super.key});

  Stream<List<Map<String, dynamic>>> fetchFeedbacks() {
    return FirebaseFirestore.instance
        .collection('feedbacks')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Feedbacks'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: fetchFeedbacks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching feedbacks.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No feedbacks found.'));
          }

          final feedbacks = snapshot.data!;

          return ListView.builder(
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              final feedback = feedbacks[index];
              final formattedDate = feedback['date'] != null
                  ? DateFormat('yyyy-MM-dd – kk:mm')
                      .format(DateTime.parse(feedback['date']))
                  : 'No Date';

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(feedback['name'] ?? 'No Name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Email: ${feedback['email'] ?? 'No Email'}'),
                      const SizedBox(height: 4),
                      Text('Message: ${feedback['message'] ?? 'No Message'}'),
                      const SizedBox(height: 4),
                      Text('Date: $formattedDate'),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

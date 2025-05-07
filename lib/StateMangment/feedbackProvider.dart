// lib/StateMangment/feedback_provider.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saftey_net/Model/feedbackModel.dart';

class FeedbackProvider with ChangeNotifier {
  bool isLoading = false;

  Future<void> submitFeedback(FeedbackModel feedback) async {
    isLoading = true;
    notifyListeners();

    try {
      await FirebaseFirestore.instance
          .collection('feedbacks')
          .add(feedback.toMap());
    } catch (e) {
      debugPrint("Error submitting feedback: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}

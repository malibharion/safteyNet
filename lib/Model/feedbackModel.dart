class FeedbackModel {
  final String feedback;
  final DateTime timestamp;

  FeedbackModel({
    required this.feedback,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'feedback': feedback,
      'timestamp': timestamp,
    };
  }
}

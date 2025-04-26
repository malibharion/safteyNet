import 'package:cloud_firestore/cloud_firestore.dart';

class Complaint {
  final String id;
  final String type;
  final String description;
  final String location;
  final DateTime date;
  final bool isUrgent;
  final String? status; // <-- Added nullable status

  Complaint({
    required this.id,
    required this.type,
    required this.description,
    required this.location,
    required this.date,
    required this.isUrgent,
    this.status, // <-- Added here
  });

  factory Complaint.fromMap(Map<String, dynamic> map, String id) {
    return Complaint(
      id: id,
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      isUrgent: map['isUrgent'] ?? false,
      status: map['status'], // <-- Fetching status if available
    );
  }
}

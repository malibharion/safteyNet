import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintModel {
  final String type;
  final String description;
  final String imageUrl;
  final String location;
  final String severityOrOption;
  final String areaType;
  final String status;
  final DateTime timestamp;

  ComplaintModel({
    required this.type,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.severityOrOption,
    required this.areaType,
    required this.status,
    required this.timestamp,
  });

  factory ComplaintModel.fromMap(Map<String, dynamic> map) {
    return ComplaintModel(
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      location: map['location'] ?? '',
      severityOrOption: map['severityOrOption'] ?? '',
      areaType: map['areaType'] ?? '',
      status: map['status'] ?? 'pending',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}

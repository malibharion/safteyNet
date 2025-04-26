class UserFeedback {
  final String id;
  final String name;
  final String email;
  final String message;
  final DateTime date;

  UserFeedback({
    required this.id,
    required this.name,
    required this.email,
    required this.message,
    required this.date,
  });

  // Convert to Map (for sending to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'message': message,
      'date': date.toIso8601String(), // Save date as ISO String
    };
  }

  // Convert from Map (for reading from Firestore)
  factory UserFeedback.fromMap(Map<String, dynamic> map) {
    return UserFeedback(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      message: map['message'] ?? '',
      date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
    );
  }
}

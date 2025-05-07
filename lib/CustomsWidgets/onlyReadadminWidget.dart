import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadOnlyComplaintCard extends StatelessWidget {
  final Map<String, dynamic> complaint;

  const ReadOnlyComplaintCard({super.key, required this.complaint});

  void _openMap(String location) async {
    final Uri uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(location)}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch Google Maps');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (complaint['imageUrl'] != null)
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                complaint['imageUrl'],
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(complaint['type'] ?? 'Type',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 4),
                Text(complaint['description'] ?? 'No Description'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(child: Text(complaint['location'] ?? 'Unknown')),
                    IconButton(
                      onPressed: () => _openMap(complaint['location']),
                      icon: const Icon(Icons.map, color: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Status: ${complaint['status']}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: complaint['status'] == 'approved'
                        ? Colors.green
                        : complaint['status'] == 'rejected'
                            ? Colors.red
                            : Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

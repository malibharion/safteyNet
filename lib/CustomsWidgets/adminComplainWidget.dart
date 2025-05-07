import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/StateMangment/language.dart';
import '../../StateMangment/adminComplainProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class ActionComplaintCard extends StatelessWidget {
  final Map<String, dynamic> complaint;

  const ActionComplaintCard({super.key, required this.complaint});

  Future<void> _openMap(double latitude, double longitude) async {
    final googleMapsUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");

    // Optional: for Android native maps app
    final androidMapUrl =
        Uri.parse("geo:$latitude,$longitude?q=$latitude,$longitude");

    try {
      // Try native Android geo: link
      if (await canLaunchUrl(androidMapUrl)) {
        await launchUrl(androidMapUrl);
        return;
      }

      // Fallback to Google Maps web
      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
        return;
      }

      throw Exception("No map apps available.");
    } catch (e) {
      print("Failed to launch map: $e");
      throw Exception(
          "Could not launch Google Maps. Please install it or check your browser.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ComplaintManagerProvider>(context, listen: false);

    final localizationProvider = Provider.of<LocalizationProvider>(context);

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
            padding: const EdgeInsets.all(6.0),
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
                      onPressed: () {
                        final lat = complaint['latitude'] as double?;
                        final lng = complaint['longitude'] as double?;

                        if (lat != null && lng != null) {
                          _openMap(lat, lng).catchError((e) {
                            print('Failed to open maps: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Failed to open maps: $e')),
                            );
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Location data is missing or invalid')),
                          );
                          print('Location data is missing or invalid');
                        }
                      },
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
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            await provider.updateComplaintStatus(
                                complaint['id'], 'pending');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                          child: Text(
                            localizationProvider.locale.languageCode == 'en'
                                ? 'Pending'
                                : 'زیر التواء',
                          )),
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            await provider.updateComplaintStatus(
                                complaint['id'], 'approved');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: Text(
                            localizationProvider.locale.languageCode == 'en'
                                ? 'Approve'
                                : 'منظور کریں',
                          )),
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            await provider.updateComplaintStatus(
                                complaint['id'], 'rejected');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: Text(
                            localizationProvider.locale.languageCode == 'en'
                                ? 'Reject'
                                : 'رد کریں',
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

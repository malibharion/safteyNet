import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/Model/communityModel.dart';
import 'package:saftey_net/StateMangment/communityProvider.dart';
import 'package:saftey_net/StateMangment/language.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch complaints here
    Future.microtask(() =>
        Provider.of<CommunityProvider>(context, listen: false)
            .fetchComplaints());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CommunityProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: localizationProvider.locale.languageCode == 'en'
            ? Text("Community Complaints")
            : Text("کمیونٹی شکایات"),
        backgroundColor: Colors.blue,
      ),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : provider.complaints.isEmpty
              ? Center(
                  child: Text(
                    localizationProvider.locale.languageCode == 'en'
                        ? "No complaints found."
                        : "کوئی شکایات نہیں ملیں",
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: provider.complaints.length,
                  itemBuilder: (context, index) {
                    final complaint = provider.complaints[index];
                    return ComplaintCard(complaint: complaint);
                  },
                ),
    );
  }
}

class ComplaintCard extends StatelessWidget {
  final ComplaintModel complaint;

  const ComplaintCard({super.key, required this.complaint});

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'resolved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (complaint.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  complaint.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  complaint.type,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: getStatusColor(complaint.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    complaint.status.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            ),
            const SizedBox(height: 6),
            Text(complaint.description),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _infoChip(Icons.location_on, complaint.location),
                _infoChip(Icons.warning, complaint.severityOrOption),
                _infoChip(Icons.map, complaint.areaType),
                _infoChip(Icons.schedule,
                    '${complaint.timestamp.toLocal()}'.split('.')[0]),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16, color: Colors.blue),
      label: Text(label),
      backgroundColor: Colors.grey.shade100,
    );
  }
}

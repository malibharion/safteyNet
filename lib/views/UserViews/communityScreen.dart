import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:saftey_net/Conatants/colorsConstants.dart';
import 'package:saftey_net/Conatants/familyConstants.dart';
import 'package:saftey_net/Models/model.dart';
import 'package:url_launcher/url_launcher.dart'; // assuming your Complaint model is here

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);
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

  Stream<List<Complaint>> fetchComplaints() {
    return FirebaseFirestore.instance
        .collection('complaints')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        print(data);
        return Complaint(
          id: doc.id,
          type: data['category'] ?? '',
          description: data['description'] ?? '',
          location: data['location'] ?? '',
          date: (data['date'] as Timestamp).toDate(),
          isUrgent: data['isUrgent'] ?? false,
          status: data['status'],
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Complaints'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<List<Complaint>>(
          stream: fetchComplaints(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong!'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No complaints found.'));
            } else {
              final complaints = snapshot.data!;
              return ListView.separated(
                itemCount: complaints.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final complaint = complaints[index];
                  return _buildComplaintCard(complaint);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildComplaintCard(Complaint complaint) {
    return GestureDetector(
      onTap: () {
        _openMap(complaint.location);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Complaint Type (Top Section)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: complaint.isUrgent
                              ? Colors.red.withOpacity(0.2)
                              : AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          complaint.type,
                          style: TextStyle(
                            fontFamily: AppFonts.robotoRegular,
                            fontSize: 14.sp,
                            color: complaint.isUrgent
                                ? Colors.red
                                : AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (complaint.isUrgent) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.warning, color: Colors.red, size: 18),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Description
                  Text(
                    complaint.description,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: AppFonts.robotoLight,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Location & Date
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Location Row
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                complaint.location,
                                style: TextStyle(
                                  fontFamily: AppFonts.robotoLight,
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Date Row
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                DateFormat('MMM dd, yyyy - hh:mm a')
                                    .format(complaint.date),
                                style: TextStyle(
                                  fontFamily: AppFonts.robotoLight,
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Status Badge (Top Right)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  complaint.status ?? 'Pending', // default if null
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontFamily: AppFonts.robotoRegular,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

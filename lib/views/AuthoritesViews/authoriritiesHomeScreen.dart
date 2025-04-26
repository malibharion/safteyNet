// screens/authorities_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saftey_net/Conatants/colorsConstants.dart';
import 'package:saftey_net/Conatants/familyConstants.dart';

import 'package:saftey_net/Models/model.dart';
import 'package:saftey_net/views/AuthoritesViews/allComplainScreen.dart';
import 'package:saftey_net/views/AuthoritesViews/complainDetailScreen.dart';
import 'package:saftey_net/views/AuthoritesViews/feedBacksScreens.dart';
import 'package:saftey_net/views/AuthoritesViews/rejectedComplainScreen.dart';
import 'package:saftey_net/views/AuthoritesViews/solvedComplainScreen.dart';

class AuthoritiesScreen extends StatefulWidget {
  const AuthoritiesScreen({super.key});

  @override
  State<AuthoritiesScreen> createState() => _AuthoritiesScreenState();
}

class _AuthoritiesScreenState extends State<AuthoritiesScreen> {
  List<Complaint> complaints = [];

  @override
  void initState() {
    super.initState();
    fetchPendingComplaints();
  }

  Future<void> fetchPendingComplaints() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('complaints')
          .where('status', isEqualTo: 'pending')
          .orderBy('date', descending: true)
          .get();

      setState(() {
        complaints = querySnapshot.docs
            .map((doc) => Complaint.fromMap(doc.data(), doc.id))
            .toList();
      });
    } catch (e) {
      print('Error fetching pending complaints: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complaint Dashboard',
          style: TextStyle(
            fontFamily: AppFonts.robotoRegular,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: fetchPendingComplaints,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildStatCard(
                    title: 'Complaints',
                    color: AppColors.primary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllComplaintsScreen()),
                      );
                    },
                  ),
                  _buildStatCard(
                    title: 'Rejected',
                    color: Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const RejectedComplaintsScreen()),
                      );
                    },
                  ),
                  _buildStatCard(
                    title: 'Processed',
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SolvedComplaintsScreen()),
                      );
                    },
                  ),
                  _buildStatCard(
                    title: 'Feedback',
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const FeedbackScreenAuthorirties(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Recent Complaints',
                style: TextStyle(
                  fontFamily: AppFonts.robotoRegular,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              complaints.isEmpty
                  ? const Center(child: Text('No recent complaints'))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: complaints.length > 5 ? 5 : complaints.length,
                      itemBuilder: (context, index) {
                        final complaint = complaints[index];
                        return _buildComplaintItem(complaint);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: AppFonts.robotoRegular,
              fontSize: 18,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComplaintItem(Complaint complaint) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(
          complaint.type,
          style: TextStyle(
            fontFamily: AppFonts.robotoRegular,
          ),
        ),
        subtitle: Text(
          complaint.description,
          style: TextStyle(
            fontFamily: AppFonts.robotoLight,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ComplaintDetailsScreen(complaint: complaint),
            ),
          );
        },
      ),
    );
  }
}

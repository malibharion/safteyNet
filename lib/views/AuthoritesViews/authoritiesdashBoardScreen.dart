import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/StateMangment/adminComplainProvider.dart';
import 'package:saftey_net/StateMangment/language.dart';
import 'package:saftey_net/views/AuthoritesViews/allComplaintScreen.dart';
import 'package:saftey_net/views/AuthoritesViews/complainScreenFilter.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int total = 0;
  int pending = 0;
  int approved = 0;
  int rejected = 0;

  @override
  void initState() {
    super.initState();
    fetchCounts();
  }

  Future<void> fetchCounts() async {
    final provider =
        Provider.of<ComplaintManagerProvider>(context, listen: false);

    await provider.fetchComplaints();
    final all = provider.complaints;

    setState(() {
      total = all.length;
      pending = all.where((e) => e['status'] == 'pending').length;
      approved = all.where((e) => e['status'] == 'approved').length;
      rejected = all.where((e) => e['status'] == 'rejected').length;
    });
  }

  Widget _buildStatusCard(String title, int count, Color color, String status) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ComplaintListScreen(filterStatus: status),
            ));
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 24,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(color: color, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          localizationProvider.locale.languageCode == 'en'
              ? 'Admin Dashboard'
              : 'ایڈمن ڈیش بورڈ',
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchCounts,
        displacement: 40.0,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.only(bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AllComplaintsScreen(),
                      ));
                },
                child: Column(
                  children: [
                    Text(
                      localizationProvider.locale.languageCode == 'en'
                          ? 'Total Complaints'
                          : 'کل شکایات',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      total.toString(),
                      style: const TextStyle(
                        fontSize: 36,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusCard(
                  localizationProvider.locale.languageCode == 'en'
                      ? 'Pending'
                      : 'زیر التواء',
                  pending,
                  Colors.orange,
                  'pending',
                ),
                _buildStatusCard(
                  localizationProvider.locale.languageCode == 'en'
                      ? 'Rejected'
                      : 'مسترد شدہ',
                  rejected,
                  Colors.red,
                  'rejected',
                ),
                _buildStatusCard(
                  localizationProvider.locale.languageCode == 'en'
                      ? 'Approved'
                      : 'منظور شدہ',
                  approved,
                  Colors.green,
                  'approved',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/StateMangment/language.dart';

import '../../CustomsWidgets/adminComplainWidget.dart';
import '../../StateMangment/adminComplainProvider.dart';

class AllComplaintsScreen extends StatelessWidget {
  const AllComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizationProvider.locale.languageCode == 'en'
              ? 'All Complaints'
              : 'تمام شکایات',
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Consumer<ComplaintManagerProvider>(
        builder: (context, provider, _) {
          final complaints = provider.complaints;

          if (complaints.isEmpty) {
            return Center(
              child: Text(
                localizationProvider.locale.languageCode == 'en'
                    ? 'No complaints found.'
                    : 'کوئی شکایت نہیں ملی۔',
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: complaints.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final complaint = complaints[index];
              return ActionComplaintCard(complaint: complaint);
            },
          );
        },
      ),
    );
  }
}

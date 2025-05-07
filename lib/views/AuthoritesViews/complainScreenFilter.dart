import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/StateMangment/language.dart';

import '../../CustomsWidgets/adminDashBoardWidget.dart';
import '../../StateMangment/adminComplainProvider.dart';

class ComplaintListScreen extends StatelessWidget {
  final String filterStatus;

  const ComplaintListScreen({super.key, required this.filterStatus});

  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${filterStatus[0].toUpperCase()}${filterStatus.substring(1)} Complaints"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Consumer<ComplaintManagerProvider>(builder: (context, provider, _) {
        final filtered = provider.complaints
            .where((e) => e['status'] == filterStatus)
            .toList();

        if (filtered.isEmpty) {
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
          itemCount: filtered.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final complaint = filtered[index];
            return ComplaintCard(complaint: complaint, provider: provider);
          },
        );
      }),
    );
  }
}

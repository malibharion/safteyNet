import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/CustomsWidgets/complaintForm.dart';
import 'package:saftey_net/StateMangment/complaintProvider.dart';

import '../../../StateMangment/language.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => ComplaintProvider(),
      child: ComplaintForm(
        title: localizationProvider.locale.languageCode == 'en'
            ? 'Health Info'
            : 'صحت کی معلومات',
        typeOptions: localizationProvider.locale.languageCode == 'en'
            ? ['Pharmacy', 'Hospital', 'Clinic']
            : ['فارمیسی', 'ہسپتال', 'کلینک'],
        areaOptions: localizationProvider.locale.languageCode == 'en'
            ? ['Urban Area', 'Rural Area']
            : ['شہری علاقہ', 'دیہی علاقہ'],
        thirdOptions: localizationProvider.locale.languageCode == 'en'
            ? ['Low', 'Medium', 'High']
            : ['کم', 'درمیانہ', 'زیادہ'],
      ),
    );
  }
}

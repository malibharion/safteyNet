import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/CustomsWidgets/complaintForm.dart';
import 'package:saftey_net/StateMangment/complaintProvider.dart';
import 'package:saftey_net/StateMangment/language.dart';

class DisasterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => ComplaintProvider(),
      child: ComplaintForm(
        title: localizationProvider.locale.languageCode == 'en'
            ? 'Emergency Info'
            : 'ایمرجنسی کی معلومات',
        typeOptions: localizationProvider.locale.languageCode == 'en'
            ? ['Earthquake', 'Flood']
            : ['زلزلہ', 'سیلاب'],
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

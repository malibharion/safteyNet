import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/CustomsWidgets/complaintForm.dart';
import 'package:saftey_net/StateMangment/complainManagment.dart';
import 'package:saftey_net/StateMangment/language.dart';

class CorruptioScreen extends StatefulWidget {
  const CorruptioScreen({super.key});

  @override
  State<CorruptioScreen> createState() => _CorruptioScreenState();
}

class _CorruptioScreenState extends State<CorruptioScreen> {
  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => ComplaintProvider(),
      child: ComplaintForm(
        title: localizationProvider.locale.languageCode == 'en'
            ? 'Corruption Info'
            : 'بدعنوانی کی معلومات',
        typeOptions: localizationProvider.locale.languageCode == 'en'
            ? ['Money Laundering', 'Political Corruption', 'Other']
            : ['منی لانڈرنگ', 'سیاسی بدعنوانی', 'دوسرا'],
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

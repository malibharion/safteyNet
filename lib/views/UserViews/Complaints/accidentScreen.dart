import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/CustomsWidgets/complaintForm.dart';
import 'package:saftey_net/StateMangment/complainManagment.dart';
import 'package:saftey_net/StateMangment/language.dart';

class AccidentScreen extends StatefulWidget {
  const AccidentScreen({super.key});

  @override
  State<AccidentScreen> createState() => _AccidentScreenState();
}

class _AccidentScreenState extends State<AccidentScreen> {
  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => ComplaintProvider(),
      child: ComplaintForm(
        title: localizationProvider.locale.languageCode == 'en'
            ? 'Accident Info'
            : 'حادثے کی معلومات',
        typeOptions: localizationProvider.locale.languageCode == 'en'
            ? ['Vehicle Accident', 'Pedestrian Accident', 'Other Accident']
            : ['گاڑی کا حادثہ', 'پیادہ چلنے والا حادثہ', 'دوسرا حادثہ'],
        areaOptions: localizationProvider.locale.languageCode == 'en'
            ? ['Urban Area', 'Rural Area']
            : ['شہری علاقہ', 'دیہی علاقہ'],
        thirdOptions: localizationProvider.locale.languageCode == 'en'
            ? ['Minor', 'Major', 'Fatal']
            : ['چھوٹا', 'بڑا', 'مہلک'],
      ),
    );
  }
}

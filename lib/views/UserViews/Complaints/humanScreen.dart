import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/CustomsWidgets/complaintForm.dart';
import 'package:saftey_net/StateMangment/complaintProvider.dart';
import 'package:saftey_net/StateMangment/language.dart';

class HumanRightScreen extends StatefulWidget {
  const HumanRightScreen({super.key});

  @override
  State<HumanRightScreen> createState() => _HumanRightScreenState();
}

class _HumanRightScreenState extends State<HumanRightScreen> {
  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => ComplaintProvider(),
      child: ComplaintForm(
        title: localizationProvider.locale.languageCode == 'en'
            ? 'Human Rights Info'
            : 'انسانی حقوق کی معلومات',
        typeOptions: localizationProvider.locale.languageCode == 'en'
            ? ['Bribery', 'Human Trafficking', 'Other']
            : ['رشوت خوری', 'انسانی اسمگلنگ', 'دوسرا'],
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

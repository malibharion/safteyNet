import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/CustomsWidgets/gridItem.dart';
import 'package:saftey_net/CustomsWidgets/topBarContainer.dart';
import 'package:saftey_net/StateMangment/language.dart';
import 'package:saftey_net/views/UserViews/Complaints/accidentScreen.dart';
import 'package:saftey_net/views/UserViews/Complaints/corruptionScreen.dart';
import 'package:saftey_net/views/UserViews/Complaints/disasterScreen.dart';
import 'package:saftey_net/views/UserViews/Complaints/healthScreen.dart';
import 'package:saftey_net/views/UserViews/Complaints/humanScreen.dart';

class ComplaintMainScreen extends StatefulWidget {
  const ComplaintMainScreen({super.key});

  @override
  State<ComplaintMainScreen> createState() => _ComplaintMainScreenState();
}

class _ComplaintMainScreenState extends State<ComplaintMainScreen> {
  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    final items = [
      {
        'title':
            localizationProvider.locale.languageCode == 'en' ? 'Health' : 'صحت',
        'image': 'assets/images/health.png',
        'screen': HealthScreen()
      },
      {
        'title': 'Accident',
        'image': 'assets/images/accident.png',
        'screen': AccidentScreen()
      },
      {
        'title': localizationProvider.locale.languageCode == 'en'
            ? 'Disaster'
            : 'آفات',
        'image': 'assets/images/disaster.png',
        'screen': DisasterScreen()
      },
      {
        'title': localizationProvider.locale.languageCode == 'en'
            ? 'Corruption'
            : 'بدعنوانی',
        'image': 'assets/images/corruption.png',
        'screen': CorruptioScreen()
      },
      {
        'title': localizationProvider.locale.languageCode == 'en'
            ? 'Human Rights'
            : 'انسانی حقوق',
        'image': 'assets/images/humanRights.png',
        'screen': HumanRightScreen()
      },
    ];
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: TopBarContainer()),
            SliverPadding(
              padding: EdgeInsets.all(12),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => GridItem(
                    title: items[index]['title'] as String,
                    imagePath: items[index]['image'] as String,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => items[index]['screen'] as Widget),
                      );
                    },
                  ),
                  childCount: items.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

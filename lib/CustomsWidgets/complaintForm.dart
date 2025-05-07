import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/StateMangment/complaintProvider.dart';
import 'package:saftey_net/StateMangment/language.dart';

class ComplaintForm extends StatelessWidget {
  final String title;
  final List<String> typeOptions;
  final List<String> areaOptions;
  final List<String> thirdOptions;

  const ComplaintForm({
    required this.title,
    required this.typeOptions,
    required this.areaOptions,
    required this.thirdOptions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ComplaintProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(12),
      ),
      hintStyle: const TextStyle(color: Colors.grey),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                hint: Text(
                  localizationProvider.locale.languageCode == 'en'
                      ? 'Select the type'
                      : 'قسم منتخب کریں',
                ),
                value: provider.selectedType,
                decoration: inputDecoration,
                items: typeOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: provider.updateType,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                hint: Text(
                  localizationProvider.locale.languageCode == 'en'
                      ? 'Area Type'
                      : 'علاقے کی قسم',
                ),
                value: provider.areaType,
                decoration: inputDecoration,
                items: areaOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: provider.updateAreaType,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                hint: Text(
                  localizationProvider.locale.languageCode == 'en'
                      ? 'Severity / Option'
                      : 'شدت / آپشن',
                ),
                value: provider.severityOrOption,
                decoration: inputDecoration,
                items: thirdOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: provider.updateSeverity,
              ),
              const SizedBox(height: 16),
              TextFormField(
                maxLines: 4,
                decoration: inputDecoration.copyWith(
                  hintText: localizationProvider.locale.languageCode == 'en'
                      ? 'Description'
                      : 'تفصیل',
                ),
                onChanged: provider.updateDescription,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: provider.getLocation,
                  icon: const Icon(Icons.location_pin),
                  label: Text(
                    provider.location ??
                        (localizationProvider.locale.languageCode == 'en'
                            ? 'Add Location'
                            : 'مقام شامل کریں'),
                  )),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: provider.pickImage,
                  icon: const Icon(Icons.image),
                  label: Text(
                    localizationProvider.locale.languageCode == 'en'
                        ? "Add Image"
                        : "تصویر شامل کریں",
                  )),
              const SizedBox(height: 12),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    await provider.submitComplaint();
                    final url = await provider.uploadImageToFirebase();

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                          localizationProvider.locale.languageCode == 'en'
                              ? 'Complaint submitted successfully!'
                              : 'شکایت کامیابی سے جمع کر دی گئی!',
                        )),
                      );

                      await Future.delayed(const Duration(milliseconds: 100));

                      Navigator.of(context).pop();
                    }

                    provider.reset();
                  },
                  child: Text(
                    localizationProvider.locale.languageCode == 'en'
                        ? "Submit"
                        : "جمع کریں",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

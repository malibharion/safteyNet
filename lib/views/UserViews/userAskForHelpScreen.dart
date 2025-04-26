import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/StateMangment/complainManagment.dart';
import 'package:saftey_net/Conatants/colorsConstants.dart';
import 'package:saftey_net/CustomsWidgets/backGroundImageContainer.dart';

class AskForHelpScreen extends StatefulWidget {
  const AskForHelpScreen({super.key});

  @override
  State<AskForHelpScreen> createState() => _AskForHelpScreenState();
}

class _AskForHelpScreenState extends State<AskForHelpScreen> {
  final TextEditingController _complaintController = TextEditingController();
  final List<String> _categories = [
    'Robbery',
    'Accident',
    'Harassment',
    'Theft',
    'Medical Emergency',
    'Fire',
    'Other'
  ];

  @override
  void dispose() {
    _complaintController.dispose();
    super.dispose();
  }

  Future<void> _submitComplaint(BuildContext context) async {
    final provider = Provider.of<ComplaintProvider>(context, listen: false);

    if (provider.selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category')),
      );
      return;
    }

    if (provider.complaintText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe your complaint')),
      );
      return;
    }

    if (provider.selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date')),
      );
      return;
    }

    try {
      await provider.submitComplaint();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complaint submitted successfully!')),
      );
      Navigator.pop(context); // Return to previous screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit complaint: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ComplaintProvider>(context);

    return SafeArea(
      child: BackgroundImageWithContainer(
        backgroundImagePath: 'assets/images/image 105 (5).png',
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Register a Complaint',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              // Category Dropdown
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonFormField<String>(
                  value: provider.selectedCategory,
                  hint: const Text('Select Complaint Category'),
                  items: _categories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) => provider.setCategory(value),
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Complaint Description
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: _complaintController,
                  onChanged: provider.setComplaintText,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Describe your complaint in detail...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Date Picker
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: provider.selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) provider.setDate(picked);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 10),
                      Text(
                        provider.selectedDate != null
                            ? '${provider.selectedDate!.day}/${provider.selectedDate!.month}/${provider.selectedDate!.year}'
                            : 'Select Date',
                        style: TextStyle(
                          color: provider.selectedDate != null
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Location Preview
              if (provider.location != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Location: ${provider.location}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: provider.isSubmitting
                      ? null
                      : () => _submitComplaint(context),
                  child: provider.isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Submit Complaint'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

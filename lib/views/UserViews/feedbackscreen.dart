// lib/Screens/feedback_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/Model/feedbackModel.dart';
import 'package:saftey_net/StateMangment/feedbackProvider.dart';
import 'package:saftey_net/StateMangment/language.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final feedbackProvider = Provider.of<FeedbackProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizationProvider.locale.languageCode == 'en'
              ? 'Feedback'
              : 'رائے',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                localizationProvider.locale.languageCode == 'en'
                    ? "We'd love your feedback!"
                    : "ہمیں آپ کی رائے بہت پسند آئے گی!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _controller,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: localizationProvider.locale.languageCode == 'en'
                      ? "Type your feedback here..."
                      : "اپنی رائے یہاں لکھیں...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return localizationProvider.locale.languageCode == 'en'
                        ? "Feedback can't be empty"
                        : "رائے خالی نہیں ہو سکتی";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: feedbackProvider.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              final model = FeedbackModel(
                                feedback: _controller.text.trim(),
                                timestamp: DateTime.now(),
                              );

                              await feedbackProvider.submitFeedback(model);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                localizationProvider.locale.languageCode == 'en'
                                    ? "Feedback submitted"
                                    : "رائے جمع کر دی گئی",
                              )));

                              _controller.clear();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: feedbackProvider.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            localizationProvider.locale.languageCode == 'en'
                                ? "Submit"
                                : "جمع کریں",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

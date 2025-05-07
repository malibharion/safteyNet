import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ComplaintProvider with ChangeNotifier {
  String? selectedType;
  String? areaType;
  String? severityOrOption;
  String description = '';
  String? location;
  File? image;
  double? latitude;
  String? locationError;
  double? longitude;

  void updateType(String? value) {
    selectedType = value;
    notifyListeners();
  }

  void updateAreaType(String? value) {
    areaType = value;
    notifyListeners();
  }

  void updateSeverity(String? value) {
    severityOrOption = value;
    notifyListeners();
  }

  void updateDescription(String value) {
    description = value;
    notifyListeners();
  }

  Future<void> getLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locationError = 'Location services are disabled.';
        notifyListeners();
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          locationError = 'Location permissions are denied';
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        locationError =
            'Location permissions are permanently denied, we cannot request permissions.';
        notifyListeners();
        return;
      }

      // Get the current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(const Duration(seconds: 10));

      // Get address from coordinates
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Update location data
      latitude = position.latitude;
      longitude = position.longitude;
      location = '${placemarks.first.locality}, ${placemarks.first.country}';
      locationError = null; // Clear any previous errors
      notifyListeners();
    } catch (e) {
      locationError = 'Could not get location: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      image = File(picked.path);
      notifyListeners();
    }
  }

  Future<String?> uploadImageToFirebase() async {
    if (image == null) return null;
    final fileName = basename(image!.path);
    final ref = FirebaseStorage.instance.ref().child('complaints/$fileName');
    await ref.putFile(image!);
    return await ref.getDownloadURL();
  }

  void reset() {
    selectedType = null;
    areaType = null;
    severityOrOption = null;
    description = '';
    location = null;
    image = null;
    notifyListeners();
  }

  Future<void> submitComplaint() async {
    try {
      final imageUrl = await uploadImageToFirebase();

      await FirebaseFirestore.instance.collection('complaints').add({
        'type': selectedType,
        'areaType': areaType,
        'severityOrOption': severityOrOption,
        'description': description,
        'location': location,
        'imageUrl': imageUrl,
        'status': 'pending',
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("Complaint submitted successfully.");
      reset();
    } catch (e) {
      print("Error submitting complaint: $e");
    }
  }
}

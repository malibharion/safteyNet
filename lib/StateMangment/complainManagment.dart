// providers/complaint_provider.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class ComplaintProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _selectedCategory;
  String _complaintText = '';
  DateTime? _selectedDate;
  String? _location;
  bool _isSubmitting = false;

  // Getters
  String? get selectedCategory => _selectedCategory;
  String get complaintText => _complaintText;
  DateTime? get selectedDate => _selectedDate;
  String? get location => _location;
  bool get isSubmitting => _isSubmitting;

  // Setters
  void setCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setComplaintText(String text) {
    _complaintText = text;
    notifyListeners();
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      // Get position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        _location =
            '${place.locality}, ${place.administrativeArea}, ${place.country}';
      }
    } catch (e) {
      print('Location error: $e');
      _location = 'Location not available';
    }
  }

  Future<void> submitComplaint() async {
    try {
      _isSubmitting = true;
      notifyListeners();

      await _getCurrentLocation();

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not logged in');

      await _firestore.collection('complaints').add({
        'userId': user.uid,
        'category': _selectedCategory,
        'description': _complaintText,
        'date': _selectedDate,
        'location': _location,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
        'coordinates': GeoPoint(
          (await Geolocator.getCurrentPosition()).latitude,
          (await Geolocator.getCurrentPosition()).longitude,
        ),
      });

      // Reset form
      _selectedCategory = null;
      _complaintText = '';
      _selectedDate = null;
      _location = null;
    } catch (e) {
      print('Error submitting complaint: $e');
      rethrow;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}

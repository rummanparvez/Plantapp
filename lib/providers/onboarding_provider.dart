import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  int _currentPage = 0;
  final int _totalPages = 5;
  
  // User data collected during onboarding
  String? _name;
  String? _email;
  String? _password;
  List<String> _selectedPreferences = [];

  // Getters
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  bool get isLastPage => _currentPage == _totalPages - 1;
  String? get name => _name;
  String? get email => _email;
  String? get password => _password;
  List<String> get selectedPreferences => _selectedPreferences;

  // Navigation methods
  void nextPage() {
    if (_currentPage < _totalPages - 1) {
      _currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      notifyListeners();
    }
  }

  void goToPage(int page) {
    if (page >= 0 && page < _totalPages) {
      _currentPage = page;
      notifyListeners();
    }
  }

  // Data collection methods
  void setUserData({String? name, String? email, String? password}) {
    if (name != null) _name = name;
    if (email != null) _email = email;
    if (password != null) _password = password;
    notifyListeners();
  }

  void togglePreference(String preference) {
    if (_selectedPreferences.contains(preference)) {
      _selectedPreferences.remove(preference);
    } else {
      _selectedPreferences.add(preference);
    }
    notifyListeners();
  }

  void clearPreferences() {
    _selectedPreferences = [];
    notifyListeners();
  }

  // Reset onboarding
  void reset() {
    _currentPage = 0;
    _name = null;
    _email = null;
    _password = null;
    _selectedPreferences = [];
    notifyListeners();
  }
}
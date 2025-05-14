import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _hasCompletedOnboarding = false;
  String? _username;
  String? _email;

  // Getters
  bool get isLoggedIn => _isLoggedIn;
  bool get hasCompletedOnboarding => _hasCompletedOnboarding;
  String? get username => _username;
  String? get email => _email;

  // Constructor - try to load saved state
  AuthProvider() {
    _loadFromPrefs();
  }

  // Load authentication state from shared preferences
  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _hasCompletedOnboarding = prefs.getBool('hasCompletedOnboarding') ?? false;
    _username = prefs.getString('username');
    _email = prefs.getString('email');
    notifyListeners();
  }

  // Save authentication state to shared preferences
  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', _isLoggedIn);
    await prefs.setBool('hasCompletedOnboarding', _hasCompletedOnboarding);
    if (_username != null) await prefs.setString('username', _username!);
    if (_email != null) await prefs.setString('email', _email!);
  }

  // Mark onboarding as completed
  Future<void> completeOnboarding() async {
    _hasCompletedOnboarding = true;
    await _saveToPrefs();
    notifyListeners();
  }

  // Login method
  Future<bool> login(String email, String password) async {
    // Simplified login logic for demonstration
    // In a real app, you would make API calls to your backend
    if (email.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn = true;
      _email = email;
      _username = email.split('@').first; // Simple username extraction
      await _saveToPrefs();
      notifyListeners();
      return true;
    }
    return false;
  }

  // Register method
  Future<bool> register(String email, String password, String name) async {
    // Simplified registration logic for demonstration
    if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
      _isLoggedIn = true;
      _email = email;
      _username = name;
      await _saveToPrefs();
      notifyListeners();
      return true;
    }
    return false;
  }

  // Logout method
  Future<void> logout() async {
    _isLoggedIn = false;
    await _saveToPrefs();
    notifyListeners();
  }
}
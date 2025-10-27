import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  bool _isLoading = false;
  Map<String, dynamic>? _userProfile;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;
  Map<String, dynamic>? get userProfile => _userProfile;

  AuthProvider() {
    _init();
  }

  void _init() {
    _user = _authService.getCurrentUser();
    if (_user != null) {
      _loadUserProfile();
    }
    _authService.onAuthStateChange().listen((event) {
      _user = event.session?.user;
      if (_user != null) {
        _loadUserProfile();
      } else {
        _userProfile = null;
      }
      notifyListeners();
    });
  }

  Future<void> _loadUserProfile() async {
    if (_user != null) {
      try {
        _userProfile = await _authService.getUserProfile(_user!.id);
      } catch (e) {
        // Handle error silently for now
        _userProfile = null;
      }
      notifyListeners();
    }
  }

  Future<void> signIn(String phone) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.signInWithPhone(phone);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.signInWithEmail(email, password);
      // User will be set via auth state change listener
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUpWithEmail(String email, String password, String fullName) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.signUpWithEmail(email, password);
      _user = response.session?.user;

      // Create profile if user was created
      if (_user != null) {
        await _authService.createUserProfile(
          userId: _user!.id,
          fullName: fullName,
          email: email,
        );
        await _loadUserProfile();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyOTP(String phone, String otp, {Map<String, dynamic>? userDetails}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.verifyOTP(phone, otp);
      _user = response.session?.user;

      // Create profile if it doesn't exist
      if (_user != null) {
        await _authService.createUserProfile(
          userId: _user!.id,
          fullName: userDetails?['fullName'],
          email: userDetails?['email'],
        );
        await _loadUserProfile();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    _userProfile = null;
    notifyListeners();
  }

  Future<void> updateProfile(Map<String, dynamic> updates) async {
    if (_user != null) {
      await _authService.updateUserProfile(_user!.id, updates);
      await _loadUserProfile();
    }
  }
}
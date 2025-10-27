import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Sign in with phone number
  Future<void> signInWithPhone(String phone) async {
    await _supabase.auth.signInWithOtp(
      phone: phone,
      shouldCreateUser: true,
    );
  }

  // Sign in with email and password
  Future<void> signInWithEmail(String email, String password) async {
    await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign up with email and password
  Future<AuthResponse> signUpWithEmail(String email, String password) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  // Verify OTP
  Future<AuthResponse> verifyOTP(String phone, String otp) async {
    return await _supabase.auth.verifyOTP(
      phone: phone,
      token: otp,
      type: OtpType.sms,
    );
  }

  // Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  // Listen to auth state changes
  Stream<AuthState> onAuthStateChange() {
    return _supabase.auth.onAuthStateChange;
  }

  // Update user profile
  Future<void> updateUserProfile(String userId, Map<String, dynamic> updates) async {
    await _supabase
        .from('profiles')
        .update(updates)
        .eq('id', userId);
  }

  // Create user profile
  Future<void> createUserProfile({
    required String userId,
    required String fullName,
    required String email,
  }) async {
    await _supabase
        .from('profiles')
        .insert({
          'id': userId,
          'full_name': fullName,
          'email': email,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
  }

  // Get user profile
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();

    return response;
  }
}
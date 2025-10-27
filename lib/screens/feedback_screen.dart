// lib/screens/feedback_screen.dart
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _feedbackController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _feedbackController.text.trim();

    // ===== PLACE TO SEND DATA =====
    // Right now we just print to console and show a SnackBar.
    // Replace this block with an API call or Firebase write when ready.
    debugPrint('Feedback submitted: name=$name, email=$email, message=$message');

    await Future.delayed(const Duration(milliseconds: 500)); // small UX delay

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Thanks for your feedback, ${name.isEmpty ? 'friend' : name}!'),
        backgroundColor: Colors.green[700],
        behavior: SnackBarBehavior.floating,
      ),
    );

    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    _feedbackController.clear();

    setState(() => _isSubmitting = false);
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your email';
    final email = v.trim();
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) return 'Enter a valid email';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text(
                  'We’d love to hear from you',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Your full name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (v) => v == null || v.trim().isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'you@example.com',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _feedbackController,
                  decoration: const InputDecoration(
                    labelText: 'Feedback',
                    hintText: 'Tell us what you think...',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.feedback),
                  ),
                  maxLines: 6,
                  minLines: 4,
                  textInputAction: TextInputAction.newline,
                  validator: (v) => v == null || v.trim().isEmpty ? 'Please enter feedback' : null,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isSubmitting ? null : _submitForm,
                    icon: _isSubmitting ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2.0)) : const Icon(Icons.send),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Text(_isSubmitting ? 'Submitting...' : 'Submit'),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                    _nameController.clear();
                    _emailController.clear();
                    _feedbackController.clear();
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// User profile model

class UserProfile {
  final String name;
  final String email;
  final String phoneNumber;
  final List<String> vehicles;
  
  UserProfile({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.vehicles,
  });
  
  // Get the initials from the name (e.g., "John Doe" -> "JD")
  String get initials {
    final nameParts = name.split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}';
    } else if (nameParts.length == 1 && nameParts[0].isNotEmpty) {
      return nameParts[0][0];
    }
    return '';
  }
}
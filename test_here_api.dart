import 'dart:convert';
import 'package:http/http.dart' as http;

class Place {
  final String title;
  final String address;
  final dynamic position;

  Place({required this.title, required this.address, required this.position});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      title: json['title'] ?? 'Unknown Place',
      address: json['address']?['label'] ?? 'Unknown Address',
      position: json['position'],
    );
  }
}

void main() async {
  final apiKey = 'PUHHzIgjYra4TWDAisBgc9DWQwwIJ5_Y16yOi9fWBCY';
  final centerLat = 38.6368;
  final centerLng = -90.2336;

  // Test HERE Discover API (this should work with your API key)
  final url = Uri.parse(
    'https://discover.search.hereapi.com/v1/discover?at=$centerLat,$centerLng&q=parking&limit=20&apiKey=$apiKey'
  );

  try {
    print('Testing HERE API call...');
    final response = await http.get(url);
    print('Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Response: $data');

      final results = data['items'] as List? ?? [];
      print('Found ${results.length} parking spots');

      final places = results.map((item) => Place.fromJson(item)).toList();
      for (var place in places) {
        print('Place: ${place.title} - ${place.address}');
      }
    } else {
      print('Error: ${response.body}');
    }
  } catch (e) {
    print('Exception: $e');
  }
}
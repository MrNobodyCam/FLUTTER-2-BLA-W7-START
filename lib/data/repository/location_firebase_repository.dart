import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/location/locations.dart' show Country, Location;
import './locations_repository.dart';

class LocationFirebaseRepository implements LocationsRepository {
  final String firebaseUrl;

  LocationFirebaseRepository({required this.firebaseUrl});

  @override
  Future<List<Location>> getLocations() async {
    try {
      final response = await http.get(Uri.parse('$firebaseUrl/Location.json'));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        if (response.body == 'null') {
          print('No locations found in the database.');
          return [];
        }

        final Map<String, dynamic> data = jsonDecode(response.body);
        return data.entries
            .map((entry) => Location(
                  name: entry.value['name'],
                  country: Country.fromString(entry.value['country']),
                ))
            .toList();
      } else {
        throw Exception('Failed to load locations: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching locations: $e');
      throw Exception('Error fetching locations: $e');
    }
  }
}

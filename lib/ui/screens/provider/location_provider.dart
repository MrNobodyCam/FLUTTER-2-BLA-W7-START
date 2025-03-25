import 'package:flutter/material.dart';
import '../../../model/location/locations.dart';
import 'async_value.dart';
import '../../../data/repository/locations_repository.dart';

class LocationProvider extends ChangeNotifier {
  final LocationsRepository repository;
  late AsyncValue<List<Location>> locations;

  LocationProvider({required this.repository}) {
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    locations = AsyncValue.loading();
    notifyListeners();

    try {
      final fetchedLocations = await repository.getLocations();
      locations = AsyncValue.success(fetchedLocations);
    } catch (error) {
      locations = AsyncValue.error(error);
    }

    notifyListeners();
  }
}

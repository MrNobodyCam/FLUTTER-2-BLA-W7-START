import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/data/repository/local/local_ride_preferences_repository.dart';

// import '../../../data/repository/ride_preferences_repository.dart';
import '../../../data/repository/rides_repository.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride/ride_filter.dart';
import '../../../model/ride/ride_pref.dart';
import 'async_value.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  late AsyncValue<List<RidePreference>> pastPreferences;
  final LocalRidePreferencesRepository repository;
  final RidesRepository ridesRepository;

  RidesPreferencesProvider({
    required this.repository,
    required this.ridesRepository,
  }) {
    fetchPastPreferences();
  }

  RidePreference? get currentPreference => _currentPreference;

  Future<void> fetchPastPreferences() async {
    pastPreferences = AsyncValue.loading();
    notifyListeners();

    try {
      List<RidePreference> pastPrefs = await repository.getPastPreferences();
      pastPreferences = AsyncValue.success(pastPrefs);
    } catch (error) {
      pastPreferences = AsyncValue.error(error);
    }

    notifyListeners();
  }

  void setCurrentPreference(RidePreference pref) {
    if (_currentPreference == pref) return;
    _currentPreference = pref;
    addPreference(pref);
    notifyListeners();
  }

  Future<void> addPreference(RidePreference preference) async {
    try {
      await repository.addPastPreference(preference);
      await fetchPastPreferences();
    } catch (error) {
      pastPreferences = AsyncValue.error(error);
      notifyListeners();
    }
  }

  List<RidePreference> get preferencesHistory {
    if (pastPreferences.state == AsyncValueState.success) {
      return pastPreferences.data?.reversed.toList() ?? [];
    }
    return [];
  }

  List<Ride> getRidesFor(RidePreference pref, RideFilter? filter) {
    return ridesRepository.getRidesFor(pref, filter);
  }
}

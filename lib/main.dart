import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/data/repository/local/local_ride_preferences_repository.dart';
import 'package:week_3_blabla_project/data/repository/location_firebase_repository.dart';
import 'data/repository/mock/mock_rides_repository.dart';
import 'ui/screens/provider/location_provider.dart';
import 'ui/screens/provider/ride_pref_provider.dart';
import 'ui/screens/ride_pref/ride_pref_screen.dart';
import 'ui/theme/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RidesPreferencesProvider(
            repository: LocalRidePreferencesRepository(),
            ridesRepository: MockRidesRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(
            repository: LocationFirebaseRepository(
              firebaseUrl:
                  "https://week7-mobile-8966b-default-rtdb.asia-southeast1.firebasedatabase.app",
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const Scaffold(
        body: RidePrefScreen(),
      ),
    );
  }
}

import '../location/locations.dart';

///
/// This model describes a ride preference.
/// A ride preference consists of the selection of a departure + arrival + a date and a number of passenger
///
class RidePreference {
  final Location departure;
  final DateTime departureDate;
  final Location arrival;
  final int requestedSeats;

  const RidePreference(
      {required this.departure,
      required this.departureDate,
      required this.arrival,
      required this.requestedSeats});

  @override
  String toString() {
    return 'RidePref(departure: ${departure.name}, '
        'departureDate: ${departureDate.toIso8601String()}, '
        'arrival: ${arrival.name}, '
        'requestedSeats: $requestedSeats)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RidePreference) return false;
    return other.departure == departure &&
        other.departureDate == departureDate &&
        other.arrival == arrival &&
        other.requestedSeats == requestedSeats;
  }

  @override
  int get hashCode {
    return Object.hash(
      departure,
      departureDate,
      arrival,
      requestedSeats,
    );
  }
}

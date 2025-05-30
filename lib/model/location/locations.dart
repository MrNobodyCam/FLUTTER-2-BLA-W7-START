///
/// Enumation of available BlaBlaCar countries
///
enum Country {
  france('France'),
  uk('United Kingdom'),
  cambodia('Cambodia'),
  spain('Spain'),
  thailand('Thailand');

  final String name;

  const Country(this.name);

  static Country fromString(String value) {
    return Country.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
    );
  }
}

///
/// This model describes a location (city, street).
///
class Location {
  final String name;
  final Country country;

  const Location({required this.name, required this.country});

  // Copy constructor
  Location.copy(Location other)
      : name = other.name,
        country = other.country;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Location && other.name == name && other.country == country;
  }

  @override
  int get hashCode => name.hashCode ^ country.hashCode;

  @override
  String toString() {
    return name;
  }
}

import 'dart:math';

/// Calculates the distance in meters between two geographic coordinates using the Haversine formula.
///
/// The Haversine formula determines the great-circle distance between two points on a sphere
/// given their longitudes and latitudes. This function assumes the Earth is a perfect sphere
/// with a radius of 6,371,000 meters.
///
/// Parameters:
/// - [lat1]: Latitude of the first point in decimal degrees.
/// - [lon1]: Longitude of the first point in decimal degrees.
/// - [lat2]: Latitude of the second point in decimal degrees.
/// - [lon2]: Longitude of the second point in decimal degrees.
///
/// Returns:
/// - The distance between the two points in meters as a [double].
///
/// Example:
/// ```dart
/// double distance = haversineMeters(41.0082, 28.9784, 40.7128, -74.0060);
/// ```
double haversineMeters(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371000; // Radio de la Tierra en metros
  final dLat = _deg2rad(lat2 - lat1);
  final dLon = _deg2rad(lon2 - lon1);
  final a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return R * c;
}

double _deg2rad(double deg) => deg * pi / 180;

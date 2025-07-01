import 'dart:convert';

DriverLocationModel driverLocationFromJson(String str) =>
    DriverLocationModel.fromJson(json.decode(str));

String driverLocationToJson(DriverLocationModel data) =>
    json.encode(data.toJson());

class DriverLocationModel {
  int driverId;
  String name;
  Location location;
  double speed;

  DriverLocationModel({
    required this.driverId,
    required this.name,
    required this.location,
    required this.speed,
  });

  factory DriverLocationModel.fromJson(Map<String, dynamic> json) =>
      DriverLocationModel(
        driverId: json["driverId"],
        name: json["driverName"],
        location: Location.fromJson(json["location"]),
        speed: json["speed"],
      );

  Map<String, dynamic> toJson() => {
    "driverId": driverId,
    "name": name,
    "location": location.toJson(),
    "speed": speed,
  };
}

class Location {
  double latitude;
  double longitude;

  Location({required this.latitude, required this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(latitude: json["latitude"], longitude: json["longitude"]);

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

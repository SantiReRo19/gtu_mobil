class StopResponse {
  String message;
  List<StopModel> data;
  int status;

  StopResponse({
    required this.message,
    required this.data,
    required this.status,
  });

  factory StopResponse.fromJson(Map<String, dynamic> json) => StopResponse(
    message: json["message"],
    data: List<StopModel>.from(json["data"].map((x) => StopModel.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class StopModel {
  int id;
  String name;
  String description;
  int neighborhoodId;
  double latitude;
  double longitude;

  StopModel({
    required this.id,
    required this.name,
    required this.description,
    required this.neighborhoodId,
    required this.latitude,
    required this.longitude,
  });

  factory StopModel.fromJson(Map<String, dynamic> json) => StopModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    neighborhoodId: json["neighborhoodId"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "neighborhoodId": neighborhoodId,
    "latitude": latitude,
    "longitude": longitude,
  };
}

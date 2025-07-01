class RouteResponse {
  String message;
  List<RouteModel> data;
  int status;

  RouteResponse({
    required this.message,
    required this.data,
    required this.status,
  });

  factory RouteResponse.fromJson(Map<String, dynamic> json) => RouteResponse(
    message: json["message"],
    data: List<RouteModel>.from(
      json["data"].map((x) => RouteModel.fromJson(x)),
    ),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class RouteModel {
  int id;
  String name;
  String description;
  String startTime;
  String endTime;
  List<int> neighborhoodIds;
  List<int> stops;

  RouteModel({
    required this.id,
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.neighborhoodIds,
    required this.stops,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    neighborhoodIds: List<int>.from(json["neighborhoodIds"].map((x) => x)),
    stops: List<int>.from(json["stops"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "startTime": startTime,
    "endTime": endTime,
    "neighborhoodIds": List<dynamic>.from(neighborhoodIds.map((x) => x)),
    "stops": List<dynamic>.from(stops.map((x) => x)),
  };
}

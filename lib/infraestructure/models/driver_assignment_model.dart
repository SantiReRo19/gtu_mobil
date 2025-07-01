class DriverAssigneResponde {
  String message;
  List<DriverAssignmentModel> data;
  int status;

  DriverAssigneResponde({
    required this.message,
    required this.data,
    required this.status,
  });

  factory DriverAssigneResponde.fromJson(Map<String, dynamic> json) =>
      DriverAssigneResponde(
        message: json["message"],
        data: List<DriverAssignmentModel>.from(
          json["data"].map((x) => DriverAssignmentModel.fromJson(x)),
        ),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class DriverAssignmentModel {
  int id;
  int driverId;
  int routeId;
  int? currentStopId;
  int? latestStopId;
  int? nextStopId;

  DriverAssignmentModel({
    required this.id,
    required this.driverId,
    required this.routeId,
    required this.currentStopId,
    required this.latestStopId,
    required this.nextStopId,
  });

  factory DriverAssignmentModel.fromJson(Map<String, dynamic> json) =>
      DriverAssignmentModel(
        id: json["id"],
        driverId: json["driverId"],
        routeId: json["routeId"],
        currentStopId: json["currentStopId"],
        latestStopId: json["latestStopId"],
        nextStopId: json["nextStopId"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "driverId": driverId,
    "routeId": routeId,
    "currentStopId": currentStopId,
    "latestStopId": latestStopId,
    "nextStopId": nextStopId,
  };
}

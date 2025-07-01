class NeighborhoodResponse {
  String message;
  List<NeighborhoodModel> data;
  int status;

  NeighborhoodResponse({
    required this.message,
    required this.data,
    required this.status,
  });

  factory NeighborhoodResponse.fromJson(Map<String, dynamic> json) =>
      NeighborhoodResponse(
        message: json["message"],
        data: List<NeighborhoodModel>.from(
          json["data"].map((x) => NeighborhoodModel.fromJson(x)),
        ),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class NeighborhoodModel {
  int id;
  String name;

  NeighborhoodModel({required this.id, required this.name});

  factory NeighborhoodModel.fromJson(Map<String, dynamic> json) =>
      NeighborhoodModel(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

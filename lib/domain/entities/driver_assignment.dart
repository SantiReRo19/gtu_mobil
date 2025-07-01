class DriverAssignment {
  final int id;
  final int driverId;
  final int routeId;
  final int? currentStopId;
  final int? latestStopId;
  final int? nextStopId;

  DriverAssignment({
    required this.id,
    required this.driverId,
    required this.routeId,
    required this.currentStopId,
    required this.latestStopId,
    required this.nextStopId,
  });
}

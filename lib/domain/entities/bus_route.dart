class BusRoute {
  final int id;
  final String name;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final List<int> neighborhoods;
  final List<int> stops;

  const BusRoute({
    required this.id,
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.neighborhoods,
    required this.stops,
  });
}

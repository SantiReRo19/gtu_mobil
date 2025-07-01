import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/config/providers/bus_route_repository_provider.dart';
import 'package:gtu_mobile/domain/entities/neighborhood.dart';
import 'package:gtu_mobile/domain/repositories/bus_route_repository.dart';

final neighborhoodProvider =
    StateNotifierProvider<NeighborhoodNotifier, NeighborhoodState>(
      (ref) => NeighborhoodNotifier(ref.watch(busRouteRepositoryProvider)),
    );

class NeighborhoodNotifier extends StateNotifier<NeighborhoodState> {
  NeighborhoodNotifier(this._busRouteRepository) : super(NeighborhoodState()) {
    _init();
  }
  final BusRouteRepository _busRouteRepository;

  void _init() async {
    try {
      final neighborhoods = await _busRouteRepository.getAllNeighborhoods();
      state = state.copyWith(neighborhoods: neighborhoods);
    } catch (e) {
      state = state.copyWith(neighborhoods: []);
    }
  }

  void onSelectNeighborhood(int index) {
    if (index == -1) {
      state = state.copyWith(clearSelected: true);
      return;
    }
    if (index < 0 || index >= state.neighborhoods.length) return;
    state = state.copyWith(selectedNeighborhood: state.neighborhoods[index]);
  }
}

class NeighborhoodState {
  final List<Neighborhood> neighborhoods;
  final Neighborhood? selectedNeighborhood;

  NeighborhoodState({this.neighborhoods = const [], this.selectedNeighborhood});

  NeighborhoodState copyWith({
    List<Neighborhood>? neighborhoods,
    Neighborhood? selectedNeighborhood,
    bool clearSelected = false,
  }) {
    return NeighborhoodState(
      neighborhoods: neighborhoods ?? this.neighborhoods,
      selectedNeighborhood: clearSelected
          ? null
          : selectedNeighborhood ?? this.selectedNeighborhood,
    );
  }
}

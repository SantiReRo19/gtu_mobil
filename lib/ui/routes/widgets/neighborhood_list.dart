import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/ui/routes/providers/neighborhood_provider.dart';
import 'package:gtu_mobile/ui/routes/providers/routes_provider.dart';
import 'package:gtu_mobile/ui/routes/widgets/neighborhood_item.dart';

class NeighborhoodList extends ConsumerWidget {
  const NeighborhoodList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(neighborhoodProvider);
    ref.listen(neighborhoodProvider, (previous, next) {
      if (previous?.selectedNeighborhood != next.selectedNeighborhood) {
        ref
            .read(routesProvider.notifier)
            .onFilterRoutesNeighborhood(next.selectedNeighborhood);
      }
    });
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              'Seleccione un barrio',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 32,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            itemCount: state.neighborhoods.length + 1,
            separatorBuilder: (context, index) => const SizedBox(width: 16),

            itemBuilder: (context, index) {
              if (index == 0) {
                return NeighborhoodItem(
                  isSelected: state.selectedNeighborhood == null,
                  label: 'Todos',
                  onTap: () {
                    ref
                        .read(neighborhoodProvider.notifier)
                        .onSelectNeighborhood(-1);
                  },
                );
              }

              final neighborhood = state.neighborhoods[index - 1];

              return NeighborhoodItem(
                isSelected: neighborhood.id == state.selectedNeighborhood?.id,
                label: neighborhood.name,
                onTap: () {
                  ref
                      .read(neighborhoodProvider.notifier)
                      .onSelectNeighborhood(index - 1);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

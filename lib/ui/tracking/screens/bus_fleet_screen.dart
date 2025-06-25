import 'package:flutter/material.dart';
import 'package:gtu_mobile/ui/home/widgets/search_route.dart';

class BusFleetScreen extends StatelessWidget {
  const BusFleetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: (height * .85) + 10,
          color: Colors.green,
        ),
        const SearchRoute(),
        DraggableScrollableSheet(
          minChildSize: .25,
          maxChildSize: .85,
          builder: (BuildContext context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.white,
              ),
              clipBehavior: Clip.antiAlias,
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    floating: true,
                    pinned: true,
                    snap: true,
                    centerTitle: true,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    surfaceTintColor: Colors.white,
                    title: const Text(
                      'Flotas en movimiento',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return ListTile(title: Text('Item $index'));
                    }, childCount: 20),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

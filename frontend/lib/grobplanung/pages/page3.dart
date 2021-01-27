import 'package:flutter/material.dart';

import '../../utils/entities/customer.dart';
import '../../utils/entities/estimate.dart';
import '../../utils/entities/item.dart';
import '../widgets/page3/bottom_bar.dart';
import '../widgets/page3/custom_list.dart';
import '../widgets/page3/list_bar.dart';
import '../widgets/page3/side_box.dart';

class Page3 extends StatelessWidget {
  final Estimate estimate;
  final bool loaded;
  final List<Item> items;
  final Customer customer;
  final int id;
  final bool grobePlanung;
  final bool anfragenPlaner;

  const Page3({
    Key key,
    @required this.estimate,
    @required this.items,
    @required this.loaded,
    @required this.customer,
    @required this.id,
    @required this.grobePlanung,
    @required this.anfragenPlaner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loaded && estimate.optimized == true) {
      for (var id in estimate.ids.reversed.toList()) {
        Item item = items.firstWhere((element) => element.id == id,
            orElse: () => items.last);
        items.remove(item);
        items.insert(0, item);
      }
    }
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              ListBar(),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: CustomList(
                    customer: customer,
                    draftID: id,
                    estimate: estimate,
                    items: items,
                    loaded: loaded,
                    anfragenPlaner: anfragenPlaner,
                  ),
                ),
              ),
              SizedBox(height: 38),
              BottomBar(
                estimate: estimate,
                loaded: loaded,
                grobePlanung: grobePlanung,
              ),
            ],
          ),
        ),
        SizedBox(width: 38),
        Container(
          width: 307,
          color: Colors.white,
          child: SideBox(
            estimate: estimate,
            id: id,
            customer: customer,
            items: items,
            loaded: loaded,
            grobePlanung: grobePlanung,
          ),
        ),
      ],
    );
  }
}

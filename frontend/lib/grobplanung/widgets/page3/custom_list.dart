import 'package:flutter/material.dart';
import 'package:packlog/utils/entities/customer.dart';

import '../../../utils/entities/estimate.dart';
import '../../../utils/entities/item.dart';
import 'list_view_tile.dart';

class CustomList extends StatelessWidget {
  final bool loaded;
  final Estimate estimate;
  final List<Item> items;
  final bool anfragenPlaner;
  final Customer customer;
  final int draftID;

  const CustomList({
    Key key,
    @required this.loaded,
    @required this.estimate,
    @required this.items,
    @required this.anfragenPlaner,
    @required this.customer,
    @required this.draftID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    items.sort((a, b) => a.prio.compareTo(b.prio));
    if (loaded && estimate.optimized == true) {
      for (var id in estimate.ids.reversed.toList()) {
        Item item = items.firstWhere((element) => element.id == id,
            orElse: () => items.last);
        items.remove(item);
        items.insert(0, item);
      }
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => ListViewTile(
        customer: customer,
        draftID: draftID,
        estimate: estimate,
        selected: items,
        anfragenPlaner: anfragenPlaner,
        item: items[index],
        optimized: (loaded &&
            estimate.optimized &&
            estimate.ids.contains(items[index].id)),
      ),
    );
  }
}

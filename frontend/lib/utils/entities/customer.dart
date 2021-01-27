import 'package:flutter/foundation.dart';

import 'item.dart';

enum Status { green, yellow, red }

class Customer {
  int id;
  String wen;
  String name;

  List<Item> items;

  Customer({
    @required this.id,
    @required this.items,
    @required this.name,
    @required this.wen,
  });

  factory Customer.fromMap(map) {
    List<Map<String, dynamic>> list = map['items'];
    List<Item> result = [];
    for (var map in list) {
      result.add(Item.fromMap(map));
    }

    return Customer(
      id: map['id'],
      name: map['customer'],
      wen: map['WEN'],
      items: result,
    );
  }

  DateTime nextOrderDraft(int draftId) {
    return nextOrder2(
        items.where((element) => element.draftId == draftId).toList());
  }

  DateTime nextOrder2(List<Item> items) {
    return items
        .firstWhere((a) => !items.any((b) => b.date.isBefore(a.date)))
        .date;
  }

  DateTime nextOrder() {
    return items
        .firstWhere(
            (a) => a.prio == 1 && !items.any((b) => b.date.isBefore(a.date)))
        .date;
  }

  int actions() {
    return items.where((a) => a.draftId == null && a.prio == 1).length;
  }

  Status status() {
    DateTime now = DateTime.now();
    if (items.any((a) =>
        a.prio == 1 &&
        a.draftId == null &&
        a.date.difference(now).inDays <= 7)) {
      return Status.red;
    } else if (items.any((a) =>
        a.prio == 1 &&
        a.draftId == null &&
        a.date.difference(now).inDays <= 14)) {
      return Status.yellow;
    } else {
      return Status.green;
    }
  }
}

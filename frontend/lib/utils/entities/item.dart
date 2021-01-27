import 'package:flutter/foundation.dart';

class Item {
  int id;
  String name;
  int quantity;
  int prio;
  int orderId;
  DateTime date;
  int draftId;
  int requestId;
  DateTime draftDate;
  DateTime requestDate;
  bool selected;

  Item({
    @required this.id,
    @required this.date,
    @required this.draftDate,
    @required this.draftId,
    @required this.name,
    @required this.orderId,
    @required this.prio,
    @required this.quantity,
    @required this.requestDate,
    @required this.requestId,
    this.selected = false,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      prio: map['prio'],
      orderId: map['order_id'],
      draftId: map['draft_id'],
      requestId: map['request_id'],
      date: map['out_date'] == null
          ? null
          : DateTime(
              map['out_date']['y'],
              map['out_date']['m'],
              map['out_date']['d'],
            ),
      draftDate: map['draft_date'] == null
          ? null
          : DateTime(
              map['draft_date']['y'],
              map['draft_date']['m'],
              map['draft_date']['d'],
            ),
      requestDate: map['request_date'] == null
          ? null
          : DateTime(
              map['request_date']['y'],
              map['request_date']['m'],
              map['request_date']['d'],
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"quantity": quantity, "id": id, "prio": prio};
  }
}

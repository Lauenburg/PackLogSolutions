part of 'grobplanung_bloc.dart';

@immutable
abstract class GrobplanungEvent {}

class Page1Event extends GrobplanungEvent {
  final int order;

  Page1Event({this.order = 0});
}

class Page2Event extends GrobplanungEvent {
  final List<Item> items;
  final Customer customer;

  Page2Event({@required this.items, @required this.customer});
}

class Page2OrderEvent extends GrobplanungEvent {
  final int order;

  Page2OrderEvent({this.order = 0});
}

class Page2UpdateItemEvent extends Page2Event {
  final List<Item> update;

  Page2UpdateItemEvent(List<Item> items, Customer customer,
      {@required this.update})
      : super(items: items, customer: customer);
}

class Page2PopupEvent extends Page2Event {
  Page2PopupEvent(List<Item> items, Customer customer)
      : super(items: items, customer: customer);
}

class Page3Event extends GrobplanungEvent {
  final List<Item> items;
  final List<Item> selected;
  final Customer customer;

  Page3Event(
      {@required this.items, @required this.customer, @required this.selected});
}

class OptimizePage3Event extends Page3Event {
  final int id;

  OptimizePage3Event({
    @required List<Item> items,
    @required this.id,
    @required Customer customer,
    @required List<Item> selected,
  }) : super(customer: customer, items: items, selected: selected);
}

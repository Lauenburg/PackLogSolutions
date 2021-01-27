part of 'anfragen_bloc.dart';

@immutable
abstract class AnfragenEvent {}

class AnfragenPage1Event extends AnfragenEvent {}

class AnfragenPage3Event extends AnfragenEvent {
  final List<Item> selected;
  final Customer customer;
  final int id;
  final Estimate estimate;

  AnfragenPage3Event({
    @required this.customer,
    @required this.id,
    @required this.estimate,
    @required this.selected,
  });
}

class OptimizePage3Event extends AnfragenEvent {
  final int id;
  final Customer customer;
  final List<Item> items;
  final List<Item> selected;

  OptimizePage3Event({
    @required this.items,
    @required this.id,
    @required this.customer,
    @required this.selected,
  });
}

class RemoveAndUpdateEvent extends AnfragenEvent {
  final Item removeItem;
  final List<Item> selected;
  final Customer customer;
  final int id;
  final Estimate estimate;

  RemoveAndUpdateEvent({
    @required this.customer,
    @required this.id,
    @required this.estimate,
    @required this.selected,
    @required this.removeItem,
  });
}

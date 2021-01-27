part of 'grobplanung_bloc.dart';

@immutable
abstract class GrobplanungState {}

class Page1State extends GrobplanungState {
  final int order;

  Page1State(this.order);
}

class Page2State extends GrobplanungState {
  final List<Item> items;
  final Customer customer;
  final int order;

  Page2State({
    @required this.customer,
    @required this.items,
    this.order = 0,
  });
}

class Page2PopupState extends Page2State {
  final List<Item> selected;
  Page2PopupState(List<Item> items, Customer customer,
      {@required this.selected})
      : super(items: items, customer: customer);
}

class Page3State extends GrobplanungState {
  final List<Item> items;
  final List<Item> selected;
  final Customer customer;
  final int id;

  Page3State({
    @required this.customer,
    @required this.items,
    @required this.id,
    @required this.selected,
  });
}

class Page3LoadingState extends Page3State {
  Page3LoadingState({
    @required List<Item> items,
    @required List<Item> selected,
    @required Customer customer,
    @required int id,
  }) : super(
          customer: customer,
          items: items,
          id: id,
          selected: selected,
        );
}

class Page3LoadedState extends Page3State {
  final Estimate estimate;

  Page3LoadedState({
    @required List<Item> items,
    @required List<Item> selected,
    @required Customer customer,
    @required int id,
    @required this.estimate,
  }) : super(
          customer: customer,
          items: items,
          id: id,
          selected: selected,
        );
}

part of 'entwuerfe_bloc.dart';

@immutable
abstract class EntwuerfeEvent {}

class EntwuerfePage1Event extends EntwuerfeEvent {}

class EntwuerfePage3Event extends EntwuerfeEvent {
  final List<Item> selected;
  final Customer customer;
  final int id;
  final Estimate estimate;

  EntwuerfePage3Event({
    @required this.customer,
    @required this.id,
    @required this.estimate,
    @required this.selected,
  });
}

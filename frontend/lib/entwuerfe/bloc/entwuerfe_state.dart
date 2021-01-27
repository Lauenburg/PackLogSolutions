part of 'entwuerfe_bloc.dart';

@immutable
abstract class EntwuerfeState {}

class EntwuerfeInitial extends EntwuerfeState {}


class EntwuerfePage1State extends EntwuerfeState {}

class EntwuerfePage3State extends EntwuerfeState {
  final List<Item> selected;
  final Customer customer;
  final int id;
  final Estimate estimate;


  EntwuerfePage3State({
    @required this.customer,
    @required this.id,
    @required this.estimate,
    @required this.selected,
  });
}

part of 'anfragen_bloc.dart';

@immutable
abstract class AnfragenState {}

class AnfragenInitial extends AnfragenState {}

class AnfragenPage1State extends AnfragenState {}

class AnfragenPage3State extends AnfragenState {
  final List<Item> selected;
  final Customer customer;
  final int id;
  final Estimate estimate;

  AnfragenPage3State({
    @required this.customer,
    @required this.id,
    @required this.estimate,
    @required this.selected,
  });
}

class AnfragenPage3LoadingState extends AnfragenPage3State {
  final List<Item> selected;
  final Customer customer;
  final int id;
  final Estimate estimate;

  AnfragenPage3LoadingState({
   @required this.selected,
  @required this.customer,
  @required  this.id,
   @required this.estimate,
  }) : super(
          customer: customer,
          estimate: estimate,
          id: id,
          selected: selected,
        );
}

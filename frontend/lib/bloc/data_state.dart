part of 'data_bloc.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}

class DataLoaded extends DataState {
  final List<Customer> customers;
  final List<Draft> drafts;

  DataLoaded({@required this.customers, @required this.drafts});
}

part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GrobePlanungEvent extends HomeEvent {}

class EntwuerfePlanungEvent extends HomeEvent {}

class AnfragenPlanungEvent extends HomeEvent {}

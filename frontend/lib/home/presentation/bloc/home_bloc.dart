import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(GrobePlanungState());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GrobePlanungEvent) {
      yield GrobePlanungState();
    } else if (event is EntwuerfePlanungEvent) {
      yield EntwuerfePlanungState();
    } else if (event is AnfragenPlanungEvent) {
      yield AnfragenPlanerState();
    }
  }
}

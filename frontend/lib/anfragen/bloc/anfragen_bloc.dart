import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:packlog/utils/data/remote_data_source.dart';

import '../../utils/entities/customer.dart';
import '../../utils/entities/estimate.dart';
import '../../utils/entities/item.dart';

part 'anfragen_event.dart';
part 'anfragen_state.dart';

class AnfragenBloc extends Bloc<AnfragenEvent, AnfragenState> {
  AnfragenBloc() : super(AnfragenPage1State());

  @override
  Stream<AnfragenState> mapEventToState(
    AnfragenEvent event,
  ) async* {
    if (event is AnfragenPage1Event) {
      yield AnfragenPage1State();
    }
    if (event is AnfragenPage3Event) {
      yield AnfragenPage3State(
        customer: event.customer,
        id: event.id,
        estimate: event.estimate,
        selected: event.selected,
      );
    }
    if (event is OptimizePage3Event) {
      Estimate estimate =
          await RemoteDataSource().optimizedEstimation(event.selected);

      yield AnfragenPage3State(
        customer: event.customer,
        id: event.id,
        estimate: estimate,
        selected: event.selected,
      );
    }
    if (event is RemoveAndUpdateEvent) {
      if (event.selected.remove(event.removeItem)) {
        event.removeItem.draftId = null;
      }
      yield AnfragenPage3State(
        customer: event.customer,
        id: event.id,
        estimate: event.estimate,
        selected: event.selected,
      );
      yield AnfragenPage3LoadingState(
        customer: event.customer,
        estimate: event.estimate,
        id: event.id,
        selected: event.selected,
      );
      Estimate estimate =
          await RemoteDataSource().optimizedEstimation(event.selected);
      yield AnfragenPage3State(
        customer: event.customer,
        id: event.id,
        estimate: estimate,
        selected: event.selected,
      );
    }
  }
}

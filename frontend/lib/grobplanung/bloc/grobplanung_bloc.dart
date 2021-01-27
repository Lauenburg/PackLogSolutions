import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:packlog/utils/data/remote_data_source.dart';
import 'package:packlog/utils/entities/customer.dart';
import 'package:packlog/utils/entities/estimate.dart';
import 'package:packlog/utils/entities/item.dart';

part 'grobplanung_event.dart';
part 'grobplanung_state.dart';

class GrobplanungBloc extends Bloc<GrobplanungEvent, GrobplanungState> {
  GrobplanungBloc() : super(Page1State(0));

  @override
  Stream<GrobplanungState> mapEventToState(
    GrobplanungEvent event,
  ) async* {
    if (event is Page1Event) {
      yield Page1State(event.order);
    }

    if (event is Page2Event) {
      yield Page2State(items: event.items, customer: event.customer);
    }
    if (event is Page2OrderEvent) {
      if (state is Page2State) {
        yield Page2State(
          customer: (state as Page2State).customer,
          items: (state as Page2State).items,
          order: event.order,
        );
      }
    }
    if (event is Page2PopupEvent) {
      yield Page2PopupState(event.items, event.customer,
          selected: event.items.where((element) => element.selected).toList());
    }
    if (event is Page2UpdateItemEvent) {
      List<Item> list = event.items;
      for (var item in event.update) {
        list = list.map((e) => e.id == item.id ? item : e).toList();
      }
      yield Page2State(items: list, customer: event.customer);
    }
    if (event is Page3Event) {
      int id = generateID();
      yield Page3State(
        items: event.items,
        customer: event.customer,
        id: id,
        selected: event.selected,
      );
      Estimate estimate =
          await RemoteDataSource().roughEstimation(event.selected);
      yield Page3LoadedState(
        items: event.items,
        customer: event.customer,
        id: id,
        selected: event.selected,
        estimate: estimate,
      );
    }
    if (event is OptimizePage3Event) {
      int id = event.id;
      yield Page3State(
        items: event.items,
        customer: event.customer,
        id: id,
        selected: event.selected,
      );
      Estimate estimate =
          await RemoteDataSource().optimizedEstimation(event.selected);
      yield Page3LoadedState(
        items: event.items,
        customer: event.customer,
        id: id,
        selected: event.selected,
        estimate: estimate,
      );
    }
  }

  int generateID() {
    var rng = new Random();
    return rng.nextInt(100000);
  }
}

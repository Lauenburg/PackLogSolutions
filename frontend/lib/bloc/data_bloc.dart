import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:packlog/utils/data/local_data_source.dart';
import 'package:packlog/utils/entities/customer.dart';
import 'package:packlog/utils/entities/drafts.dart';
import 'package:packlog/utils/entities/estimate.dart';
import 'package:packlog/utils/entities/item.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial());

  List<Draft> drafts = [];
  List<Customer> customers = [];

  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    if (event is LoadData) {
      customers = LocalDataSource().getAllCustomer();
      yield DataLoaded(customers: customers, drafts: drafts);
    }
    if (event is AddDraftEvent) {
      drafts.add(
        Draft(
          date: DateTime.now(),
          estimate: event.estimate,
          id: event.id,
          status: event.status,
        ),
      );
      for (var item in event.selected) {
        if (item.prio == 1 || event.estimate.ids.contains(item.id)) {
          item.draftId = event.id;
        }
        item.selected = false;
      }

      yield DataLoaded(customers: customers, drafts: drafts);
    }
    if (event is DeleteDraftEvent) {
      Draft draft = drafts.firstWhere((element) => element.id == event.id);
      drafts.remove(draft);
      for (var item in event.selected) {
        item.draftId = null;
      }

      yield DataLoaded(customers: customers, drafts: drafts);
    }
    if (event is VerifyDraftEvent) {
      Draft draft = drafts.firstWhere((element) => element.id == event.id);
      draft.status = DraftStatus.done;

      yield DataLoaded(customers: customers, drafts: drafts);
    }
    if (event is UpdateData) {
      yield DataLoaded(customers: customers, drafts: drafts);
    }
    if (event is UpdateDraftEvent) {
      List<Draft> list = drafts.where((a) => a.id == event.id).toList();
      if (list.length != 0) {
        list.first.estimate = event.estimate;
      }
    }
  }
}

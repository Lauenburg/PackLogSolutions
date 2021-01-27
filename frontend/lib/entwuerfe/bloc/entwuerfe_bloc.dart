import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:packlog/utils/entities/customer.dart';
import 'package:packlog/utils/entities/estimate.dart';
import 'package:packlog/utils/entities/item.dart';

part 'entwuerfe_event.dart';
part 'entwuerfe_state.dart';

class EntwuerfeBloc extends Bloc<EntwuerfeEvent, EntwuerfeState> {
  EntwuerfeBloc() : super(EntwuerfePage1State());

  @override
  Stream<EntwuerfeState> mapEventToState(
    EntwuerfeEvent event,
  ) async* {
    if (event is EntwuerfePage1Event) {
      yield EntwuerfePage1State();
    }
    if (event is EntwuerfePage3Event) {
      yield EntwuerfePage3State(
        customer: event.customer,
        id: event.id,
        estimate: event.estimate,
        selected: event.selected,
      );
    }
  }
}

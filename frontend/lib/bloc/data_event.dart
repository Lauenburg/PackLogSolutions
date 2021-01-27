part of 'data_bloc.dart';

@immutable
abstract class DataEvent {}

class LoadData extends DataEvent {}

class AddDraftEvent extends DataEvent {
  final Estimate estimate;
  final List<Item> selected;
  final int id;
  final DraftStatus status;

  AddDraftEvent({
    @required this.estimate,
    @required this.id,
    @required this.selected,
    @required this.status,
  });
}

class DeleteDraftEvent extends DataEvent {
  final List<Item> selected;
  final int id;

  DeleteDraftEvent({
    @required this.id,
    @required this.selected,
  });
}

class VerifyDraftEvent extends DataEvent {
  final int id;

  VerifyDraftEvent({
    @required this.id,
  });
}

class UpdateDraftEvent extends DataEvent {
  final Estimate estimate;
  final int id;

  UpdateDraftEvent({
    @required this.id,
    @required this.estimate,
  });
}

class UpdateData extends DataEvent {}

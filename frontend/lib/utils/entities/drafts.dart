import 'package:flutter/foundation.dart';
import 'package:packlog/utils/entities/estimate.dart';

class Draft {
  int id;
  Estimate estimate;
  DateTime date;
  DraftStatus status;

  Draft({
    @required this.date,
    @required this.estimate,
    @required this.id,
    @required this.status,
  });
}

enum DraftStatus { none, open, done }

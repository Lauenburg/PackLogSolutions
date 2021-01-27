import 'package:flutter/material.dart';

class Estimate {
  final List<double> one;
  final List<double> two;
  final List<double> three;
  final List<int> ids;
  final double weight;
  final bool optimized;

  List<int> box1;
  List<int> box2;
  List<int> box3;

  Estimate({
    @required this.one,
    @required this.two,
    @required this.three,
    @required this.ids,
    @required this.optimized,
    @required this.weight,
  }) {
    this.box1 = [(one[0].floor() * 1000000).toInt(), 1];

    this.box2 = [
      ((one[0] - one[0].floor()) * 1000000).toInt(),
      ((1 - (one[0] - one[0].floor())) * 1000000).toInt()
    ];
    this.box3 = [(two[1] * 1000000).toInt(), (three[1] * 1000000).toInt()];
  }

  factory Estimate.fromJson(var json) {
    Map<String, dynamic> map = json["estimate"];
    var map2 = json["n_items_last"];
    List<int> ids = [];
    if (map2 != null) {
      ids = List<int>.from(map2.map((a) => a as int));
    }

    return Estimate(
      one: [map['1'][0], map['1'][1]],
      two: [map['2'][0], map['2'][1]],
      three: [map['3'][0], map['3'][1]],
      ids: ids,
      optimized: map2 != null,
      weight: json['weight'] ?? 18273.287,
    );
  }
}

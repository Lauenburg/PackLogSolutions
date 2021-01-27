import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:packlog/utils/entities/estimate.dart';

import 'package:packlog/utils/entities/item.dart';

class RemoteDataSource {
  Future<Estimate> roughEstimation(List<Item> selected) async {
    String url = 'https://packlogsolutions.osc-fr1.scalingo.io/estimator';

    List<Map<String, dynamic>> list = [];
    for (var item in selected) {
      list.add(item.toJson());
    }
    Map map = {
      "client_id": 1,
      "order_id": 2,
      "date": null,
      "out_date": null,
      "transport_unit": "truck",
      "items_id_prio_quant": list,
    };

    Map<String, dynamic> response = await apiRequest(url, map);
    print(response);

    Estimate estimate = Estimate.fromJson(response);

    return estimate;
  }

  Future<Estimate> optimizedEstimation(List<Item> selected) async {
    String url = 'https://packlogsolutions.osc-fr1.scalingo.io/packer';

    List<Map<String, dynamic>> list = [];
    for (var item in selected) {
      list.add(item.toJson());
    }
    Map map = {
      "client_id": 1,
      "order_id": 2,
      "date": null,
      "out_date": null,
      "transport_unit": "truck",
      "items_id_prio_quant": list,
    };

    Map<String, dynamic> response = await apiRequest(url, map);
    print(response);

    Estimate estimate = Estimate.fromJson(response);

    return estimate;
  }

  Future<Map<String, dynamic>> apiRequest(String url, Map jsonMap) async {
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(jsonMap));

    print('success');

    return json.decode(response.body);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/data_bloc.dart';
import '../../bloc/grobplanung_bloc.dart';
import 'list_view_tile.dart';

class CustomList extends StatelessWidget {
  final Page1State state;

  const CustomList({Key key, @required this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(builder: (context, dataState) {
      if (dataState is DataLoaded) {
        if (state.order == 1) {
          dataState.customers.sort((a, b) => a.wen.compareTo(b.wen));
        }
        if (state.order == -1) {
          dataState.customers.sort((a, b) => b.wen.compareTo(a.wen));
        }
        if (state.order == 2) {
          dataState.customers.sort((a, b) => a.name.compareTo(b.name));
        }
        if (state.order == -2) {
          dataState.customers.sort((a, b) => b.name.compareTo(a.name));
        }
        if (state.order == 3) {
          dataState.customers
              .sort((a, b) => a.nextOrder().compareTo(b.nextOrder()));
        }
        if (state.order == -3) {
          dataState.customers
              .sort((a, b) => b.nextOrder().compareTo(a.nextOrder()));
        }
        if (state.order == 4) {
          dataState.customers
              .sort((a, b) => a.actions().compareTo(b.actions()));
        }
        if (state.order == -4) {
          dataState.customers
              .sort((a, b) => b.actions().compareTo(a.actions()));
        }
        if (state.order == 5) {
          dataState.customers.sort(
              (a, b) => a.status().toString().compareTo(b.status().toString()));
        }
        if (state.order == -5) {
          dataState.customers.sort(
              (a, b) => b.status().toString().compareTo(a.status().toString()));
        }
        return ListView.builder(
          itemCount: dataState.customers.length,
          itemBuilder: (context, index) =>
              ListViewTile(customer: dataState.customers[index]),
        );
      }
      return Container();
    });
  }
}

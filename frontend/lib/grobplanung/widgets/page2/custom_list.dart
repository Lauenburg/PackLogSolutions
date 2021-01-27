import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/grobplanung_bloc.dart';
import 'list_view_tile.dart';

class CustomList extends StatelessWidget {
  const CustomList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GrobplanungBloc, GrobplanungState>(
        builder: (context, state) {
      if (state is Page2State) {
        if (state.order == 1) {
          state.items.sort((a, b) => a.prio.compareTo(b.prio));
        }
        if (state.order == -1) {
          state.items.sort((a, b) => b.prio.compareTo(a.prio));
        }
        if (state.order == 2) {
          state.items.sort((a, b) => a.name.compareTo(b.name));
        }
        if (state.order == -2) {
          state.items.sort((a, b) => b.name.compareTo(a.name));
        }
        if (state.order == 3) {
          state.items.sort((a, b) => a.id.compareTo(b.id));
        }
        if (state.order == -3) {
          state.items.sort((a, b) => b.id.compareTo(a.id));
        }
        if (state.order == 4) {
          state.items.sort((a, b) => a.quantity.compareTo(b.quantity));
        }
        if (state.order == -4) {
          state.items.sort((a, b) => b.quantity.compareTo(a.quantity));
        }
        if (state.order == 5) {
          state.items.sort((a, b) => a.orderId.compareTo(b.orderId));
        }
        if (state.order == -5) {
          state.items.sort((a, b) => b.orderId.compareTo(a.orderId));
        }
        if (state.order == 6) {
          state.items.sort((a, b) => a.date.compareTo(b.date));
        }
        if (state.order == -6) {
          state.items.sort((a, b) => b.date.compareTo(a.date));
        }
        if (state.order == 7) {
          state.items
              .sort((a, b) => (a.draftId ?? 0).compareTo(b.draftId ?? 0));
        }
        if (state.order == -7) {
          state.items
              .sort((a, b) => (b.draftId ?? 0).compareTo(a.draftId ?? 0));
        }

        // state.items
        //     .sort((a, b) => (a.draftId ?? 0).compareTo((b.draftId ?? 0)));
        return ListView.builder(
          itemCount: state.items.length,
          itemBuilder: (context, index) =>
              ListViewTile(item: state.items[index]),
        );
      }
      return Container();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packlog/bloc/data_bloc.dart';
import 'package:packlog/utils/entities/customer.dart';
import 'package:packlog/utils/entities/item.dart';

import 'list_view_tile.dart';

class CustomList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(builder: (context, state) {
      if (state is DataLoaded) {
        return ListView.builder(
          itemCount: state.drafts.length,
          itemBuilder: (context, index) => ListViewTile(
            draft: state.drafts[index],
            customer: state.customers.firstWhere(
              (Customer a) => a.items.any(
                (Item item) => item.draftId == state.drafts[index].id,
              ),
              orElse: () => state.customers.first,
            ),
          ),
        );
      }
      return Container();
    });
  }
}

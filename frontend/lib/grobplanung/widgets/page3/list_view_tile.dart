import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packlog/anfragen/bloc/anfragen_bloc.dart';
import 'package:packlog/bloc/data_bloc.dart';
import 'package:packlog/utils/entities/customer.dart';
import 'package:packlog/utils/entities/estimate.dart';

import '../../../utils/entities/item.dart';

class ListViewTile extends StatelessWidget {
  final Item item;
  final bool optimized;
  final bool anfragenPlaner;
  final Customer customer;
  final List<Item> selected;
  final Estimate estimate;
  final int draftID;

  const ListViewTile({
    Key key,
    @required this.item,
    @required this.optimized,
    @required this.anfragenPlaner,
    @required this.customer,
    @required this.selected,
    @required this.estimate,
    @required this.draftID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: optimized
              ? Color(0xffF49D27)
              : item.prio == 1
                  ? Colors.lightGreen.withOpacity(0.1)
                  : Colors.white,
          border: Border.all(color: Color(0xffF0F0F7), width: 1),
        ),
        height: 45,
        child: Stack(
          children: [
            Center(
              child: Row(
                children: [
                  SizedBox(width: 20),
                  SizedBox(
                    width: 85,
                    child: TileText(item.prio.toString()),
                  ),
                  Expanded(
                    child: TileText(item.name),
                  ),
                  SizedBox(
                    width: 110,
                    child: TileText(item.id.toString()),
                  ),
                  SizedBox(
                    width: 110,
                    child: TileText(item.quantity.toString()),
                  ),
                  SizedBox(
                    width: 110,
                    child: TileText(item.orderId.toString()),
                  ),
                ],
              ),
            ),
            anfragenPlaner
                ? Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<AnfragenBloc>(context)
                            .add(RemoveAndUpdateEvent(
                          customer: customer,
                          estimate: estimate,
                          id: draftID,
                          removeItem: item,
                          selected: selected,
                        ));
                        BlocProvider.of<DataBloc>(context).add(UpdateData());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7.5, horizontal: 16),
                        child: Icon(
                          Icons.close,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ));
  }
}

class TileText extends StatelessWidget {
  final String text;
  const TileText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Theme.of(context).accentColor),
    );
  }
}

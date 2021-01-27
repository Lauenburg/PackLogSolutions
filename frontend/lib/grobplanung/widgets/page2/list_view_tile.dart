import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/grobplanung_bloc.dart';

import '../../../utils/entities/item.dart';

class ListViewTile extends StatelessWidget {
  final Item item;

  const ListViewTile({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GrobplanungBloc, GrobplanungState>(
      builder: (context, state) {
        if (state is Page2State) {
          return InkWell(
              onTap: () {
                if (item.draftId == null) {
                  item.selected = !item.selected;
                  BlocProvider.of<GrobplanungBloc>(context).add(
                      Page2UpdateItemEvent(state.items, state.customer,
                          update: [item]));
                }
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffF0F0F7), width: 1)),
                  height: 45,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 32,
                      ),
                      SizedBox(
                        width: 30,
                        child: SelectButton(
                          selected: item.selected,
                          item: item,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                          width: 85,
                          child: TileText(text: item.prio.toString())),
                      Expanded(child: TileText(text: item.name)),
                      SizedBox(
                          width: 110,
                          child: TileText(text: item.id.toString())),
                      SizedBox(
                          width: 110,
                          child: TileText(text: item.quantity.toString())),
                      SizedBox(
                          width: 110,
                          child: TileText(text: item.orderId.toString())),
                      SizedBox(
                          width: 140,
                          child: TileText(text: dateToString(item.date))),
                      SizedBox(
                          width: 115,
                          child: TileText(
                              text: item.draftId?.toString() ?? 'none')),
                    ],
                  )));
        }
        return Container();
      },
    );
  }

  String dateToString(DateTime date) {
    return ((date.day < 10) ? '0' : '') +
        date.day.toString() +
        '.' +
        ((date.month < 10) ? '0' : '') +
        date.month.toString() +
        '.' +
        date.year.toString();
  }
}

class SelectButton extends StatelessWidget {
  final bool selected;
  final Item item;
  const SelectButton({
    Key key,
    @required this.selected,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Opacity(
        opacity: item.draftId == null ? 1 : 0.2,
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xff3B86FF), width: 2),
            color: Colors.white,
          ),
          child: selected
              ? Center(
                  child: Icon(
                  Icons.check,
                  size: 13,
                  color: Color(0xff3B86FF),
                ))
              : Container(),
        ),
      ),
    );
  }
}

class TileText extends StatelessWidget {
  final String text;
  const TileText({this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Theme.of(context).accentColor),
    );
  }
}

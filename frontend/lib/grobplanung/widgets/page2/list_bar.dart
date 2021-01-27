import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packlog/grobplanung/bloc/grobplanung_bloc.dart';
import 'package:packlog/utils/entities/item.dart';

class ListBar extends StatelessWidget {
  final Page2State state;

  const ListBar({
    Key key,
    @required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      color: Theme.of(context).accentColor,
      child: Row(
        children: [
          SizedBox(
            width: 32,
          ),
          SizedBox(
            width: 30,
            child: SelectAllButton(),
          ),
          SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SizedBox(
              width: 65,
              child: OrderByButton(
                text: 'Prio',
                current: state.order,
                own: 1,
              ),
            ),
          ),
          Expanded(
            child: OrderByButton(
              text: 'Artikel',
              current: state.order,
              own: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SizedBox(
                width: 90,
                child: OrderByButton(
                  text: 'Item-No.',
                  current: state.order,
                  own: 3,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SizedBox(
                width: 90,
                child: OrderByButton(
                  text: 'Quantity',
                  current: state.order,
                  own: 4,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SizedBox(
                width: 90,
                child: OrderByButton(
                  text: 'Order_ID',
                  current: state.order,
                  own: 5,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SizedBox(
                width: 120,
                child: OrderByButton(
                  text: 'Lieferung\nDatum (Req.)',
                  current: state.order,
                  own: 6,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: SizedBox(
                width: 100,
                child: OrderByButton(
                  text: 'Entwurf\nNummer',
                  current: state.order,
                  own: 7,
                )),
          ),
        ],
      ),
    );
  }
}

class SelectAllButton extends StatelessWidget {
  const SelectAllButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: BlocBuilder<GrobplanungBloc, GrobplanungState>(
        builder: (context, state) {
          if (state is Page2State) {
            bool selected = !state.items.any((element) => !element.selected);
            return InkWell(
              onTap: () {
                List<Item> list = state.items;
                for (var item in list
                    .where((element) => element.draftId == null)
                    .toList()) {
                  item.selected = !selected;
                }
                BlocProvider.of<GrobplanungBloc>(context).add(
                    Page2UpdateItemEvent(state.items, state.customer,
                        update: list));
              },
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
            );
          }
          return Container();
        },
      ),
    );
  }
}

class OrderByButton extends StatelessWidget {
  final String text;
  final int current;
  final int own;

  const OrderByButton({
    this.text = '',
    @required this.current,
    @required this.own,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => BlocProvider.of<GrobplanungBloc>(context).add(
          Page2OrderEvent(
              order: (current.abs() == own) ? current * (-1) : own)),
      child: Container(
        color: Theme.of(context).accentColor,
        child: Center(
          child: SizedBox(
            height: 18,
            child: Row(
              children: [
                Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

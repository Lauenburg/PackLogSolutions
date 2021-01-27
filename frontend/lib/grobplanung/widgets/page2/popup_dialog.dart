import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packlog/utils/entities/customer.dart';

import '../../../utils/entities/item.dart';
import '../../bloc/grobplanung_bloc.dart';

class PopUpDialog extends StatelessWidget {
  const PopUpDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: SizedBox(
          height: 562,
          width: 780,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Color(0xffF0F0F7),
                height: 39,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Sollen die folgenden Artikel geplant werden?',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Expanded(child: CustomList()),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomList extends StatelessWidget {
  const CustomList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GrobplanungBloc, GrobplanungState>(
      builder: (context, state) {
        if (state is Page2PopupState) {
          return Column(
            children: [
              ListBar(),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: state.selected.length,
                    itemBuilder: (context, index) =>
                        CustomListTile(item: state.selected[index]),
                  ),
                ),
              ),
              SizedBox(height: 10),
              BottomBar(
                items: state.items,
                customer: state.customer,
                selected: state.selected,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class ListBar extends StatelessWidget {
  const ListBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).accentColor,
        height: 45,
        child: Row(
          children: [
            SizedBox(width: 20),
            SizedBox(
              width: 85,
              child: Text(
                'Prio',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Text('Artikel',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700)),
            ),
            SizedBox(
              width: 110,
              child: Text(
                'Item-No.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              width: 110,
              child: Text(
                'Quantity',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              width: 110,
              child: Text(
                'Order_ID',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ));
  }
}

class CustomListTile extends StatelessWidget {
  final Item item;

  const CustomListTile({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xffF0F0F7), width: 1),
        ),
        height: 45,
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

class BottomBar extends StatelessWidget {
  final List<Item> items;
  final List<Item> selected;
  final Customer customer;

  const BottomBar({
    Key key,
    @required this.items,
    @required this.customer,
    @required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'Transporttyp: LKW 3-Achsen',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 155,
              color: Colors.white,
              child: Center(
                child: Text(
                  'Abbrechen',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              BlocProvider.of<GrobplanungBloc>(context).add(
                Page3Event(
                  items: items,
                  customer: customer,
                  selected: selected,
                ),
              );
              Navigator.of(context).pop();
            },
            child: Container(
              width: 155,
              color: Theme.of(context).accentColor,
              child: Center(
                child: Text(
                  'Plan',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/entities/customer.dart';
import '../../bloc/grobplanung_bloc.dart';

class ListViewTile extends StatelessWidget {
  final Customer customer;

  const ListViewTile({Key key, this.customer}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime next = customer.nextOrder();
    return InkWell(
      onTap: () => BlocProvider.of<GrobplanungBloc>(context)
          .add(Page2Event(items: customer.items, customer: customer)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffF0F0F7), width: 1)),
        height: 45,
        child: Row(
          children: [
            Spacer(
              flex: 22,
            ),
            Expanded(
              flex: 266,
              child: TileText(text: customer.wen),
            ),
            Expanded(
              flex: 276,
              child: TileText(text: customer.name),
            ),
            Expanded(
              flex: 222,
              child: TileText(
                text: ((next.day < 10) ? '0' : '') +
                    next.day.toString() +
                    '.' +
                    ((next.month < 10) ? '0' : '') +
                    next.month.toString() +
                    '.' +
                    next.year.toString(),
              ),
            ),
            Expanded(
              flex: 189,
              child: TileText(
                  text: customer.status() == Status.green
                      ? '0'
                      : customer.actions().toString()),
            ),
            Expanded(
              flex: 146,
              child: StatusButton(status: customer.status()),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusButton extends StatelessWidget {
  final Status status;
  const StatusButton({@required this.status});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: (status == Status.red)
                ? Color(0xffFF4141).withOpacity(0.2)
                : (status == Status.yellow)
                    ? Color(0xffF8FF35).withOpacity(0.5)
                    : Color(0xff4AD991).withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: (status == Status.red)
                  ? Color(0xffFF4141)
                  : (status == Status.yellow)
                      ? Colors.yellow[700]
                      : Color(0xff4AD991),
            ),
          ),
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

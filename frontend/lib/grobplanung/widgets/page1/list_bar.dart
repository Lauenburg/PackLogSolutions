import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packlog/grobplanung/bloc/grobplanung_bloc.dart';

class ListBar extends StatelessWidget {
  final Page1State state;

  const ListBar({Key key, @required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      color: Theme.of(context).accentColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 13),
        child: Row(
          children: [
            Spacer(
              flex: 22,
            ),
            Expanded(
              flex: 266,
              child: OrderByButton(
                text: 'Warenempfänger Nummer',
                current: state.order,
                own: 1,
              ),
            ),
            Expanded(
              flex: 276,
              child: OrderByButton(
                text: 'Kunde',
                current: state.order,
                own: 2,
              ),
            ),
            Expanded(
              flex: 222,
              child: OrderByButton(
                text: 'Nächster Transport',
                current: state.order,
                own: 3,
              ),
            ),
            Expanded(
              flex: 189,
              child: OrderByButton(
                text: 'Artikel Aktion erforderlich',
                current: state.order,
                own: 4,
              ),
            ),
            Expanded(
              flex: 146,
              child: OrderByButton(
                text: ' Aktueller Status',
                current: state.order,
                own: 5,
              ),
            ),
          ],
        ),
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
          Page1Event(order: (current.abs() == own) ? current * (-1) : own)),
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

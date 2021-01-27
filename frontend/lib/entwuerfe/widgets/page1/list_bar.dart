import 'package:flutter/material.dart';

class ListBar extends StatelessWidget {
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
              child: OrderByButton(text: 'Warenempfänger Nummer'),
            ),
            Expanded(
              flex: 266,
              child: OrderByButton(text: 'Kunde'),
            ),
            Expanded(
              flex: 222,
              child: OrderByButton(text: 'Erstellungsdatum'),
            ),
            Expanded(
              flex: 222,
              child: OrderByButton(text: 'Lieferdatum'),
            ),
            Expanded(
              flex: 189,
              child: OrderByButton(text: 'Planungsnummer'),
            ),
            Expanded(
              flex: 146,
              child: OrderByButton(text: ' Aktueller Status'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderByButton extends StatelessWidget {
  final String text;

  const OrderByButton({this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

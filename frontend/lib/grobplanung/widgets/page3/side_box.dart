import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packlog/grobplanung/bloc/grobplanung_bloc.dart';
import 'package:packlog/utils/entities/customer.dart';
import 'package:packlog/utils/entities/estimate.dart';
import 'package:packlog/utils/entities/item.dart';

class SideBox extends StatelessWidget {
  final bool loaded;
  final Estimate estimate;
  final List<Item> items;
  final Customer customer;
  final int id;
  final bool grobePlanung;

  final double padding = 17;
  const SideBox({
    Key key,
    @required this.estimate,
    @required this.loaded,
    @required this.items,
    @required this.customer,
    @required this.id,
    @required this.grobePlanung,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Überblick Lieferung',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(color: Color(0xffE8E9EC), height: 1),
        Expanded(
          flex: 2,
          child: Container(
            height: 79,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'Spätestes Lieferdatum',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Text(
                      dateToString(
                        items
                            .firstWhere((a) =>
                                !items.any((b) => b.date.isBefore(a.date)))
                            .date,
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(color: Color(0xffE8E9EC), height: 1),
        Expanded(
          flex: 2,
          child: Container(
            height: 79,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'Ziel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Text(
                      customer.name.contains('Deutschland')
                          ? 'Berlin, Deutschland'
                          : customer.name.contains('Australien')
                              ? 'Canberra, Australien'
                              : 'Paris, Frankreich',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(color: Color(0xffE8E9EC), height: 1),
        Expanded(
          flex: 2,
          child: Container(
            height: 79,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'Kunde',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Text(
                      customer.name,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(color: Color(0xffE8E9EC), height: 1),
        Expanded(
          flex: 2,
          child: Container(
            height: 79,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'Gewicht Gesamt',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    loaded
                        ? Text(
                            estimate.weight.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : CupertinoActivityIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(color: Color(0xffE8E9EC), height: 1),
        Expanded(
          flex: 2,
          child: Container(
            height: 79,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'Maximale Priorität',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Text(
                      items
                          .firstWhere((a) => !items.any((b) => b.prio < a.prio))
                          .prio
                          .toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(color: Color(0xffE8E9EC), height: 1),
        Container(
          height: 133,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 26),
                  Text(
                    'Intelligente Empfehlung',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 26),
                  (loaded && !estimate.optimized)
                      ? grobePlanung
                          ? InkWell(
                              onTap: () =>
                                  BlocProvider.of<GrobplanungBloc>(context).add(
                                OptimizePage3Event(
                                  items: items,
                                  id: id,
                                  customer: customer,
                                  selected: items,
                                ),
                              ),
                              child: Text(
                                'Click für Optimierung',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xffF49D27),
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          : Text(
                              'Not Optimized',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xffF49D27),
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                      : Text(
                          'Optimized',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xffF49D27),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
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

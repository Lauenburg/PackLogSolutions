import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/entities/estimate.dart';

class BottomBar extends StatelessWidget {
  final bool loaded;
  final Estimate estimate;
  final bool grobePlanung;

  const BottomBar({
    Key key,
    @required this.estimate,
    @required this.loaded,
    @required this.grobePlanung,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 133,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 26),
                          Text(
                            'LKW Gesamt',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 26),
                          loaded
                              ? Text(
                                  '${estimate.one[0].floor() + 1} LKW 3-Achsen',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              : CupertinoActivityIndicator(),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 17),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 26),
                          Text(
                            'Offene Lademeter',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 26),
                          loaded
                              ? Text(
                                  estimate.optimized
                                      ? ((1 -
                                                  ((estimate.one[0] -
                                                          estimate.one[0]
                                                              .floor()) +
                                                      estimate.two[0] +
                                                      estimate.three[0])) *
                                              12)
                                          .toStringAsFixed(2)
                                      : ((1 -
                                                  (estimate.one[0] -
                                                      estimate.one[0]
                                                          .floor())) *
                                              12)
                                          .floor()
                                          .toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              : CupertinoActivityIndicator(),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 17),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 26),
                    Text(
                      'Kapazität',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 16),
                    loaded
                        ? SizedBox(
                            height: 60,
                            child: Row(
                              children: [
                                Box(list: estimate.box1),
                                SizedBox(
                                  width: 20,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20, left: 2.0, right: 2.0),
                                      child: FittedBox(child: Icon(Icons.add)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: estimate.box2[0],
                                              child: Container(
                                                color: Colors.lightGreen[200],
                                              ),
                                            ),
                                            Expanded(
                                              flex: estimate.optimized
                                                  ? ((estimate.two[0] +
                                                              estimate
                                                                  .three[0]) *
                                                          1000000)
                                                      .floor()
                                                  : 0,
                                              child: Container(
                                                color: Color(0xffF49D27),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1000000 -
                                                  estimate.box2[0] -
                                                  ((estimate.two[0] +
                                                              estimate
                                                                  .three[0]) *
                                                          1000000)
                                                      .floor(),
                                              child: Container(
                                                color: Colors.grey
                                                    .withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        'LAST TRUCK',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context).accentColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20),
                                grobePlanung
                                    ? Expanded(
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                color: Colors.grey
                                                    .withOpacity(0.6),
                                                child: Stack(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex:
                                                              estimate.box3[0],
                                                          child: Container(
                                                            color: Colors
                                                                .blue[100],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex:
                                                              estimate.box3[1],
                                                          child: Container(
                                                              color: Colors
                                                                  .blue[200]),
                                                        ),
                                                        Expanded(
                                                          flex: (max(
                                                                      (1 -
                                                                          estimate.two[
                                                                              1] -
                                                                          estimate
                                                                              .three[1]),
                                                                      0) *
                                                                  1000000)
                                                              .floor(),
                                                          child: Container(),
                                                        ),
                                                      ],
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        (estimate.two[1] +
                                                                    estimate.three[
                                                                        1])
                                                                .toStringAsFixed(
                                                                    2) +
                                                            ' LKW',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              'UNPACKED',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          )
                        : CupertinoActivityIndicator(),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Box extends StatelessWidget {
  final List<int> list;
  const Box({Key key, @required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: list[0],
                      child: Container(color: Colors.lightGreen[200]),
                    ),
                    Expanded(
                      flex: list[1],
                      child: Container(color: Colors.grey.withOpacity(0.6)),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    (list[0] / 1000000).floor().toString() + ' LKW',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6),
          Text(
            'FULL PACKED',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:packlog/grobplanung/bloc/grobplanung_bloc.dart';

import '../widgets/page1/custom_list.dart';
import '../widgets/page1/list_bar.dart';

class Page1 extends StatelessWidget {
  final Page1State state;

  const Page1({Key key, @required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListBar(state: state),
          Expanded(child: CustomList(state: state)),
        ],
      ),
    );
  }
}

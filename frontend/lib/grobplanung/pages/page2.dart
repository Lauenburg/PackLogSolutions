import 'package:flutter/material.dart';
import 'package:packlog/grobplanung/bloc/grobplanung_bloc.dart';

import '../widgets/page2/custom_list.dart';
import '../widgets/page2/list_bar.dart';

class Page2 extends StatelessWidget {
  final Page2State state;
  const Page2({
    Key key,
    @required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListBar(state: state),
          Expanded(child: CustomList()),
        ],
      ),
    );
  }
}

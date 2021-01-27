import 'package:flutter/material.dart';

import '../widgets/page1/custom_list.dart';
import '../widgets/page1/list_bar.dart';

class Page1 extends StatelessWidget {
  const Page1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListBar(),
          Expanded(child: CustomList()),
        ],
      ),
    );
  }
}

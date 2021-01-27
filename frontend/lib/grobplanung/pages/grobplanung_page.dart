import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packlog/utils/entities/item.dart';

import '../bloc/grobplanung_bloc.dart';
import '../widgets/page2/popup_dialog.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';

class Grobplanung extends StatelessWidget {
  const Grobplanung({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 37),
      child: BlocConsumer<GrobplanungBloc, GrobplanungState>(
        listener: (context, state) {
          if (state is Page2PopupState) {
            showDialog(
              context: context,
              builder: (BuildContext context) => PopUpDialog(),
            );
          }
        },
        builder: (context, state) {
          if (state is Page1State) {
            return Page1(state: state);
          } else if (state is Page2State) {
            return Page2(state: state);
          } else if (state is Page3State) {
            return Page3(
              anfragenPlaner: false,
              grobePlanung: true,
              customer: state.customer,
              items: state.selected,
              loaded: state is Page3LoadedState,
              estimate: state is Page3LoadedState ? state.estimate : null,
              id: state.id,
            );
          }
          return Container();
        },
      ),
    );
  }
}

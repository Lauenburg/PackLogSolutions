import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packlog/grobplanung/pages/page3.dart';

import '../bloc/anfragen_bloc.dart';
import 'page1.dart';

class AnfragenPage extends StatelessWidget {
  const AnfragenPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 37),
      child: BlocBuilder<AnfragenBloc, AnfragenState>(
        builder: (context, state) {
          if (state is AnfragenPage1State) {
            return Page1();
          } else if (state is AnfragenPage3State) {
            return Page3(
              anfragenPlaner: true,
              customer: state.customer,
              estimate: state.estimate,
              grobePlanung: false,
              id: state.id,
              items: state.selected,
              loaded: !(state is AnfragenPage3LoadingState),
            );
          }
          return Container();
        },
      ),
    );
  }
}

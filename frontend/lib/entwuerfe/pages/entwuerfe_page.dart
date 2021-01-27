import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packlog/grobplanung/pages/page3.dart';

import '../bloc/entwuerfe_bloc.dart';
import 'page1.dart';

class EntwuerfePage extends StatelessWidget {
  const EntwuerfePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 37),
      child: BlocBuilder<EntwuerfeBloc, EntwuerfeState>(
        builder: (context, state) {
          if (state is EntwuerfePage1State) {
            return Page1();
          } else if (state is EntwuerfePage3State) {
            return Page3(
              anfragenPlaner: false,
              customer: state.customer,
              estimate: state.estimate,
              grobePlanung: false,
              id: state.id,
              items: state.selected,
              loaded: true,
            );
          }
          return Container();
        },
      ),
    );
  }
}

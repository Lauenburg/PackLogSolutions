import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../anfragen/widgets/anfragen_app_bar.dart';
import '../../../entwuerfe/widgets/entwuerfe_app_bar.dart';
import '../../../grobplanung/widgets/grobplanung_app_bar.dart';
import '../bloc/home_bloc.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is GrobePlanungState) {
          return GrobplanungAppBar();
        }
        if (state is EntwuerfePlanungState) {
          return EntwuerfeAppBar();
        }
        if (state is AnfragenPlanerState) {
          return AnfragenAppBar();
        }
        return Container();
      },
    );
  }
}

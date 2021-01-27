import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packlog/anfragen/pages/anfragen_page.dart';

import '../../../entwuerfe/pages/entwuerfe_page.dart';
import '../../../grobplanung/pages/grobplanung_page.dart';
import '../bloc/home_bloc.dart';
import '../widgets/collapsing_naviagtion_drawer.dart';
import '../widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Stack(
        children: [
          Positioned(
            left: 66,
            bottom: 0,
            right: 0,
            top: 0,
            child: Scaffold(
              appBar: AppBar(
                
                titleSpacing: 0,
                elevation: 0,
                backgroundColor: Colors.white,
                title: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: CustomAppBar(),
                ),
              ),
              body: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is GrobePlanungState) {
                    return Grobplanung();
                  } else if (state is EntwuerfePlanungState) {
                    return EntwuerfePage();
                  } else if (state is AnfragenPlanerState) {
                    return AnfragenPage();
                  }
                  return Container();
                },
              ),
            ),
          ),
          CollapsingNavigationDrawer(),
        ],
      ),
    );
  }
}

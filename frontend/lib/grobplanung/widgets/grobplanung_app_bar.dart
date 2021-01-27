import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packlog/anfragen/bloc/anfragen_bloc.dart';
import 'package:packlog/bloc/data_bloc.dart';
import 'package:packlog/entwuerfe/bloc/entwuerfe_bloc.dart';
import 'package:packlog/home/presentation/bloc/home_bloc.dart';
import 'package:packlog/utils/entities/drafts.dart';

import '../bloc/grobplanung_bloc.dart';

class GrobplanungAppBar extends StatelessWidget {
  const GrobplanungAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GrobplanungBloc, GrobplanungState>(
      builder: (context, state) {
        if (state is Page1State) {
          return Text(
            'Warenempfänger Überblick',
            style: TextStyle(color: Theme.of(context).accentColor),
          );
        }
        if (state is Page2State) {
          return InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () =>
                BlocProvider.of<GrobplanungBloc>(context).add(Page1Event()),
            child: Row(
              children: [
                Icon(Icons.chevron_left, color: Theme.of(context).accentColor),
                SizedBox(width: 10),
                Text(
                  'Offene Artikel Warenempfänger ${state.customer.name}',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    if (state.items
                            .where((element) => element.selected == true)
                            .length !=
                        0) {
                      BlocProvider.of<GrobplanungBloc>(context)
                          .add(Page2PopupEvent(state.items, state.customer));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(4)),
                    height: 35,
                    width: 155,
                    child: Center(
                        child: Text(
                      'Plan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                  ),
                ),
                SizedBox(width: 50),
              ],
            ),
          );
        }
        if (state is Page3State) {
          return InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => BlocProvider.of<GrobplanungBloc>(context)
                .add(Page2Event(customer: state.customer, items: state.items)),
            child: Row(
              children: [
                Icon(Icons.chevron_left, color: Theme.of(context).accentColor),
                SizedBox(width: 10),
                Text(
                  'Planungsentwurf ${state.id}',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                Spacer(),
                (state is Page3LoadedState)
                    ? SizedBox(
                        width: 307,
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<DataBloc>(context)
                                      .add(AddDraftEvent(
                                    estimate: state.estimate,
                                    selected: state.selected,
                                    id: state.id,
                                    status: DraftStatus.none,
                                  ));
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(EntwuerfePlanungEvent());
                                  BlocProvider.of<GrobplanungBloc>(context)
                                      .add(Page1Event());
                                  BlocProvider.of<EntwuerfeBloc>(context)
                                      .add(EntwuerfePage1Event());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      borderRadius: BorderRadius.circular(4)),
                                  height: 35,
                                  child: Center(
                                      child: Text(
                                    'Speichern',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<DataBloc>(context)
                                      .add(AddDraftEvent(
                                    estimate: state.estimate,
                                    selected: state.selected,
                                    id: state.id,
                                    status: DraftStatus.open,
                                  ));
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(AnfragenPlanungEvent());
                                  BlocProvider.of<GrobplanungBloc>(context)
                                      .add(Page1Event());
                                  BlocProvider.of<AnfragenBloc>(context)
                                      .add(AnfragenPage1Event());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius: BorderRadius.circular(4)),
                                  height: 35,
                                  child: Center(
                                      child: Text(
                                    'Planer Anfrage',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(width: 50),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

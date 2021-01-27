import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packlog/anfragen/bloc/anfragen_bloc.dart';
import 'package:packlog/bloc/data_bloc.dart';

class AnfragenAppBar extends StatelessWidget {
  const AnfragenAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnfragenBloc, AnfragenState>(
      builder: (context, state) {
        if (state is AnfragenPage1State) {
          return Text(
            'Anfragen Planer',
            style: TextStyle(color: Theme.of(context).accentColor),
          );
        }

        if (state is AnfragenPage3State) {
          return InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => BlocProvider.of<AnfragenBloc>(context)
                .add(AnfragenPage1Event()),
            child: Row(
              children: [
                Icon(Icons.chevron_left, color: Theme.of(context).accentColor),
                SizedBox(width: 10),
                Text(
                  'Anfrage ${state.id}',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                Spacer(),
                (state is AnfragenPage3State)
                    ? SizedBox(
                        width: 307,
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<DataBloc>(context)
                                      .add(DeleteDraftEvent(
                                    selected: state.selected,
                                    id: state.id,
                                  ));
                                  BlocProvider.of<AnfragenBloc>(context)
                                      .add(AnfragenPage1Event());
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
                                    'Delete Draft',
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
                                      .add(VerifyDraftEvent(
                                    id: state.id,
                                  ));
                                  BlocProvider.of<DataBloc>(context)
                                      .add(UpdateDraftEvent(
                                    estimate: state.estimate,
                                    id: state.id,
                                  ));
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
                                    'Bestätigen',
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/data_bloc.dart';
import '../bloc/entwuerfe_bloc.dart';

class EntwuerfeAppBar extends StatelessWidget {
  const EntwuerfeAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntwuerfeBloc, EntwuerfeState>(
      builder: (context, state) {
        if (state is EntwuerfePage1State) {
          return Text(
            'Entwürfe Planung',
            style: TextStyle(color: Theme.of(context).accentColor),
          );
        }

        if (state is EntwuerfePage3State) {
          return InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => BlocProvider.of<EntwuerfeBloc>(context)
                .add(EntwuerfePage1Event()),
            child: Row(
              children: [
                Icon(Icons.chevron_left, color: Theme.of(context).accentColor),
                SizedBox(width: 10),
                Text(
                  'Planungsentwurf ${state.id}',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                Spacer(),
                (state is EntwuerfePage3State)
                    ? SizedBox(
                        width: 153,
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

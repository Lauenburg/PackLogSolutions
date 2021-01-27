import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packlog/bloc/data_bloc.dart';
import 'package:packlog/anfragen/bloc/anfragen_bloc.dart';

import '../../../utils/entities/customer.dart';
import '../../../utils/entities/drafts.dart';

class ListViewTile extends StatelessWidget {
  final Customer customer;
  final Draft draft;

  const ListViewTile({
    Key key,
    @required this.customer,
    @required this.draft,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime next = customer.nextOrderDraft(draft.id);
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) => InkWell(
        onTap: () {
          if (state is DataLoaded) {
            BlocProvider.of<AnfragenBloc>(context).add(
              AnfragenPage3Event(
                customer: customer,
                id: draft.id,
                estimate: draft.estimate,
                selected: customer.items
                    .where((element) => element.draftId == draft.id)
                    .toList(),
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xffF0F0F7), width: 1)),
          height: 45,
          child: Row(
            children: [
              Spacer(
                flex: 22,
              ),
              Expanded(
                flex: 266,
                child: TileText(text: customer.wen),
              ),
              Expanded(
                flex: 266,
                child: TileText(text: customer.name),
              ),
              Expanded(
                flex: 222,
                child: TileText(
                  text: ((draft.date.day < 10) ? '0' : '') +
                      draft.date.day.toString() +
                      '.' +
                      ((draft.date.month < 10) ? '0' : '') +
                      draft.date.month.toString() +
                      '.' +
                      draft.date.year.toString(),
                ),
              ),
              Expanded(
                flex: 222,
                child: TileText(
                  text: ((next.day < 10) ? '0' : '') +
                      next.day.toString() +
                      '.' +
                      ((next.month < 10) ? '0' : '') +
                      next.month.toString() +
                      '.' +
                      next.year.toString(),
                ),
              ),
              Expanded(
                flex: 189,
                child: TileText(text: draft.id.toString()),
              ),
              Expanded(
                flex: 146,
                child: StatusButton(status: draft.status),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusButton extends StatelessWidget {
  final DraftStatus status;
  const StatusButton({@required this.status});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: (status == DraftStatus.open)
                ? Color(0xffFF4141).withOpacity(0.2)
                : (status == DraftStatus.none)
                    ? Colors.transparent
                    : Color(0xff4AD991).withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: (status == DraftStatus.open)
                  ? Color(0xffFF4141)
                  : Color(0xff4AD991),
            ),
          ),
        ),
      ),
    );
  }
}

class TileText extends StatelessWidget {
  final String text;
  const TileText({this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Theme.of(context).accentColor),
    );
  }
}

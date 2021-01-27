import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packlog/home/presentation/bloc/home_bloc.dart';

import 'collapsing_list_tile.dart';

TextStyle listTitleDefaultTextStyle = TextStyle(
    color: Colors.white70, fontSize: 16.0, fontWeight: FontWeight.w600);
TextStyle listTitleSelectedTextStyle =
    TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600);

class NavigationModel {
  String title;
  String icon;

  NavigationModel(this.title, this.icon);
}

List<NavigationModel> navigationItems = [
  NavigationModel("Grobplanung", 'calendar.png'),
  NavigationModel("Entwürfe Planung", 'icon_Invoices.png'),
  NavigationModel("Anfragen Planer", 'icon_customers.png'),
];

class CollapsingNavigationDrawer extends StatefulWidget {
  @override
  CollapsingNavigationDrawerState createState() {
    return new CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 210;
  double minWidth = 66;
  bool isCollapsed = true;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  int currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);
    _animationController.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  Widget getWidget(context, widget) {
    return Material(
      elevation: 80.0,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is GrobePlanungState) {
            setState(() {
              currentSelectedIndex = 0;
            });
          }
          if (state is EntwuerfePlanungState) {
            setState(() {
              currentSelectedIndex = 1;
            });
          }
          if (state is AnfragenPlanerState) {
            setState(() {
              currentSelectedIndex = 2;
            });
          }
        },
        child: Container(
          width: widthAnimation.value,
          color: Theme.of(context).accentColor,
          child: Column(
            children: <Widget>[
              SizedBox(height: 25),
              InkWell(
                onTap: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                    isCollapsed
                        ? _animationController.forward()
                        : _animationController.reverse();
                  });
                },
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    AnimatedIcon(
                      icon: AnimatedIcons.close_menu,
                      progress: _animationController,
                      color: Colors.white,
                      size: 21.0,
                    ),
                    SizedBox(width: 10),
                    (widthAnimation.value >= 190)
                        ? Text(
                            'PACKLOG',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, counter) {
                    return CollapsingListTile(
                      navigationItems[counter].title,
                      navigationItems[counter].icon,
                      _animationController,
                      () {
                        if (counter == 0) {
                          BlocProvider.of<HomeBloc>(context)
                              .add(GrobePlanungEvent());
                        } else if (counter == 1) {
                          BlocProvider.of<HomeBloc>(context)
                              .add(EntwuerfePlanungEvent());
                        } else if (counter == 2) {
                          BlocProvider.of<HomeBloc>(context)
                              .add(AnfragenPlanungEvent());
                        }
                        setState(() {
                          currentSelectedIndex = counter;
                        });
                      },
                      isSelected: currentSelectedIndex == counter,
                    );
                  },
                  itemCount: navigationItems.length,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

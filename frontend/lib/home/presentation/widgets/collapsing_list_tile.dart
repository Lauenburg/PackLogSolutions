import 'package:flutter/material.dart';

TextStyle listTitleDefaultTextStyle = TextStyle(
    color: Colors.white70, fontSize: 16.0, fontWeight: FontWeight.w400);
TextStyle listTitleSelectedTextStyle =
    TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w400);

class CollapsingListTile extends StatefulWidget {
  final String title;
  final String icon;
  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;

  CollapsingListTile(
      this.title, this.icon, this.animationController, this.onTap,
      {this.isSelected = false});

  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    super.initState();
    widthAnimation =
        Tween<double>(begin: 200, end: 66).animate(widget.animationController);
    sizedBoxAnimation =
        Tween<double>(begin: 14, end: 0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(),
      child: Stack(children: [
        Container(
          height: 53,
          decoration: BoxDecoration(
            color: widget.isSelected
                ? Colors.black.withOpacity(0.1)
                : Colors.transparent,
          ),
          width: widthAnimation.value,
          // margin: EdgeInsets.symmetric(horizontal: 8.0),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            children: <Widget>[
              SizedBox(width: 14),
              SizedBox(
                width: 16,
                height: 16,
                child: FittedBox(
                  child: Image.asset(
                    'assets/icons/' + widget.icon,
                    color:
                        widget.isSelected ? Colors.white60 : Color(0xffA5A4BF),
                  ),
                ),
              ),
              SizedBox(width: sizedBoxAnimation.value),
              (widthAnimation.value >= 190)
                  ? Text(widget.title,
                      style: widget.isSelected
                          ? listTitleSelectedTextStyle
                          : listTitleDefaultTextStyle)
                  : Container(),
            ],
          ),
        ),
        widget.isSelected
            ? Container(width: 5, height: 53, color: Color(0xffA3A0FB))
            : Container(),
      ]),
    );
  }
}

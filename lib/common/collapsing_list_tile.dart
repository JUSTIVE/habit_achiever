import 'package:flutter/material.dart';
import 'package:habit_achiever/theme.dart';

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final AnimationController animationController;
  CollapsingListTile(
      {@required this.title,
      @required this.icon,
      @required this.animationController});

  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  Animation<double> _widthAnimation;
  @override
  void initState() {
    super.initState();
    _widthAnimation =
        Tween<double>(begin: 250, end: 65).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _widthAnimation.value,
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Icon(
            widget.icon,
            color: Colors.white30,
            size: 48,
          ),
          (_widthAnimation.value >= 220)
              ? Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.title,
                      style: listTitleDefaultStyle,
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

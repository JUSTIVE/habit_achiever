import 'package:flutter/material.dart';
import '../model/navigation_model.dart';
import 'collapsing_list_tile.dart';
import 'package:habit_achiever/theme.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  @override
  _CollapsingNavigationDrawerState createState() =>
      _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> widthAnimation;
  double maxWidth = 250;
  double minWidth = 65;
  bool isCollapsed = true;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = CurvedAnimation(
      parent: Tween<double>(begin: 1, end: 0)
          .animate(_animationController),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, widget) => getWidget(context, widget));
  }

  Widget getWidget(context, widget) {
    return Container(
      width: widthAnimation.value*180+70,
      color: backGroundColor,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          CollapsingListTile(
            title: "me",
            icon: Icons.person,
            animationController: _animationController,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, counter) {
                return CollapsingListTile(
                    title: navigationItems[counter].title,
                    icon: navigationItems[counter].icon,
                    animationController: _animationController);
              },
              itemCount: navigationItems.length,
            ),
          ),
          InkWell(
              onTap: () {
                setState(() {
                  isCollapsed = !isCollapsed;
                  isCollapsed
                      ? _animationController.forward()
                      : _animationController.reverse();
                });
              },
              child: AnimatedIcon(
                icon: AnimatedIcons.close_menu,
                color: Colors.white,
                size: 24,
                progress: _animationController,
              )),
          SizedBox(height: 24.0)
        ],
      ),
    );
  }
}

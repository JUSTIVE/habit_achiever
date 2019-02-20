import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularDottedGraph extends StatefulWidget {
  CircularDottedGraph({this.value, this.precision});
  final double value;
  final int precision;
  @override
  _CircularDottedGraphState createState() => _CircularDottedGraphState();
}

class _CircularDottedGraphState extends State<CircularDottedGraph>
    with SingleTickerProviderStateMixin {
  List<CircularDottedGraphIndicator> indicators =
      List<CircularDottedGraphIndicator>();
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < (100.0 / widget.precision); i++) {
      indicators.add(CircularDottedGraphIndicator(
        precision: widget.precision,
        index: i,
        value: widget.value,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Stack(children: <Widget>[
        Stack(children: indicators),
        Align(
          alignment: Alignment.center,
          child: Text(
            '${widget.value.toInt()}%',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 72),
          ),
        )
      ]),
    );
  }
}

class CircularDottedGraphIndicator extends StatefulWidget {
  CircularDottedGraphIndicator({this.precision, this.index, this.value});
  final int precision;
  final int index;
  final double value;
  @override
  _CircularDottedGraphIndicatorState createState() =>
      _CircularDottedGraphIndicatorState();
}

class _CircularDottedGraphIndicatorState
    extends State<CircularDottedGraphIndicator> {
  bool isColored;

  @override
  void initState() {
    super.initState();
    isColored = widget.value > (widget.index * widget.precision);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(MediaQuery.of(context).size.width / 2,
          MediaQuery.of(context).size.width / 2),
      child: Transform.rotate(
        angle: (360.0 / (100.0 / widget.precision)) *
            widget.index.toDouble() *
            math.pi /
            180.0,
        child: Transform.translate(
          offset: Offset(0, -150),
          child: Container(
            width: 5,
            height: 10,
            decoration: BoxDecoration(
                color: isColored
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
      ),
    );
  }
}

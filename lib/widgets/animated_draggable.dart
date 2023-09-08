import 'package:flutter/material.dart';

class XDraggable extends StatefulWidget {
  const XDraggable(
      {Key? key, required this.child, required this.originalX, required this.originalY, this.animationSpeed = 200})
      : super(key: key);
  final Widget child;
  final double originalX;
  final double originalY;
  final double animationSpeed;

  @override
  XDraggableState createState() => XDraggableState();
}

class XDraggableState extends State<XDraggable> {
  double x = 200;
  double y = 200;

  int animationSpeed = 0;

  @override
  void initState() {
    x = widget.originalX;
    y = widget.originalY;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: x,
      top: y,
      duration: Duration(milliseconds: animationSpeed),
      child: Draggable(
        onDragUpdate: (details) => {
          setState(() {
            animationSpeed = 0;
            x = x + details.delta.dx;
            y = y + details.delta.dy;
          }),
        },
        onDragEnd: (details) {
          setState(() {
            animationSpeed = 200;
            x = widget.originalX;
            y = widget.originalY;
          });
        },
        feedback: const SizedBox.shrink(),
        child: widget.child,
      ),
    );
  }
}

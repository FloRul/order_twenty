import 'package:flutter/material.dart';

class AnimatedDraggable<T extends Object> extends StatefulWidget {
  const AnimatedDraggable({
    Key? key,
    required this.builder,
    required this.data,
    this.animationDuration = const Duration(milliseconds: 200),
    required this.originalOffset,
  }) : super(key: key);
  final Widget Function(T) builder;
  final Duration animationDuration;
  final Offset originalOffset;
  final T data;

  @override
  AnimatedDraggableState<T> createState() => AnimatedDraggableState();
}

class AnimatedDraggableState<T extends Object> extends State<AnimatedDraggable<T>> {
  double x = 0;
  double y = 0;
  Duration animationDuration = Duration.zero;

  @override
  void initState() {
    x = widget.originalOffset.dx;
    y = widget.originalOffset.dy;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: x,
      top: y,
      duration: animationDuration,
      child: Draggable<T>(
        data: widget.data,
        onDragUpdate: (details) {
          setState(() {
            animationDuration = Duration.zero;
            x += details.delta.dx;
            y += details.delta.dy;
          });
        },
        onDragEnd: (details) {
          animationDuration = details.wasAccepted ? Duration.zero : widget.animationDuration;
          setState(() {
            x = widget.originalOffset.dx;
            y = widget.originalOffset.dy;
          });
        },
        feedback: widget.builder(widget.data),
        child: widget.builder(widget.data),
      ),
    );
  }
}

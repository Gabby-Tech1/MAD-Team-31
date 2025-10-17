import 'package:flutter/material.dart';

class FadeSlideAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration? delay;
  final double verticalOffset;
  final Curve curve;
  final bool isForward;
  final double horizontalOffset;

  const FadeSlideAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay,
    this.verticalOffset = 0.0,
    this.horizontalOffset = 0.0,
    this.curve = Curves.easeOut,
    this.isForward = true,
  }) : super(key: key);

  @override
  State<FadeSlideAnimation> createState() => _FadeSlideAnimationState();
}

class _FadeSlideAnimationState extends State<FadeSlideAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    // Apply delay if provided
    if (widget.delay != null) {
      Future.delayed(widget.delay!, () {
        if (mounted) {
          _controller.forward();
        }
      });
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: widget.isForward ? _animation.value : 1 - _animation.value,
          child: Transform.translate(
            offset: Offset(
              widget.horizontalOffset * (widget.isForward ? 1 - _animation.value : _animation.value),
              widget.verticalOffset * (widget.isForward ? 1 - _animation.value : _animation.value),
            ),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
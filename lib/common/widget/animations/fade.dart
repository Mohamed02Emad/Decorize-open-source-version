import 'package:flutter/material.dart';

class FadeAppearWrapper extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double beginOpacity;
  final double endOpacity;

  const FadeAppearWrapper({
    super.key,
    required this.child,
    this.beginOpacity = 0,
    this.endOpacity = 1,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<FadeAppearWrapper> createState() => _FadeAppearWrapperState();
}

class _FadeAppearWrapperState extends State<FadeAppearWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(vsync: this, duration: widget.duration);

    // Define the opacity animation (from 0 to 1)
    _animation = Tween<double>(begin: widget.beginOpacity, end: widget.endOpacity).animate(_controller);

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    // Dispose the animation controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(opacity: _animation.value, child: child);
      },
      child: widget.child,
    );
  }
}

import 'package:decorizer/common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetRipple extends StatefulWidget {
  final Widget child;
  final Color? rippleColor, backgroundColor;
  final Function()? onClick;
  final double? radius;
  final double rippleOpacity;
  final EdgeInsetsGeometry padding, margin;

  const WidgetRipple({
    Key? key,
    this.rippleOpacity = 0.5,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.radius,
    this.onClick,
    this.backgroundColor,
    required this.child,
    this.rippleColor,
  }) : super(key: key);

  @override
  _WidgetRippleState createState() => _WidgetRippleState();
}

class _WidgetRippleState extends State<WidgetRipple> {
  late bool _rippleInProgress;

  @override
  void initState() {
    super.initState();
    _rippleInProgress = false;
  }

  void startRippleAnimation() {
    setState(() {
      _rippleInProgress = true;
    });
  }

  void stopRippleAnimation() {
    setState(() {
      _rippleInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius ?? 8.h),
        child: Material(
          color: widget.backgroundColor ?? Colors.transparent,
          child: Stack(
            children: [
               widget.child,
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTapDown: (_) {
                      startRippleAnimation();
                    },
                    onTapUp: (_) {
                      stopRippleAnimation();
                    },
                    onTap: widget.onClick,
                    highlightColor: (widget.rippleColor ?? context.appColors.text.withOpacity(0.4))
                        .withOpacity(0.2),
                    splashColor: _rippleInProgress
                        ? (widget.rippleColor ?? context.appColors.text)
                        .withOpacity(widget.rippleOpacity)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(widget.radius ?? 8.h),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:decorizer/common/extentions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DynamicSliverAppBar extends StatefulWidget {
  final Widget child;
  final double maxHeight;

  const DynamicSliverAppBar(
      {super.key, this.maxHeight = 700, required this.child});

  @override
  DynamicSliverAppBarState createState() => DynamicSliverAppBarState();
}

class DynamicSliverAppBarState extends State<DynamicSliverAppBar> {
  final GlobalKey _childKey = GlobalKey();
  bool isHeightCalculated = false;
  double? height;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!isHeightCalculated) {
        setState(() {
          height = (_childKey.currentContext!.findRenderObject() as RenderBox)
                  .size
                  .height +
              10.h;
          isHeightCalculated = true;
        });
      }
    });

    return SliverAppBar(
      // shape
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      automaticallyImplyLeading: false,
      backgroundColor: context.appColors.transparent,
      surfaceTintColor: Colors.transparent,
      floating: true,
      snap: false,
      elevation: 1.h,
      collapsedHeight: isHeightCalculated ? (height!) : widget.maxHeight,
      expandedHeight: isHeightCalculated ? (height!) : widget.maxHeight,
      flexibleSpace: Column(
        children: <Widget>[
          Container(
            key: _childKey,
            child: widget.child,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

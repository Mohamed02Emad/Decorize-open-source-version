import 'dart:async';

import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/context_extension.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/app/floating_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'animations/slide.dart';

class LocationMap extends StatefulWidget {
  final LatLng? latlng;
  final Function() onClick;
  final String? title;

  const LocationMap(
      {super.key, this.latlng, required this.onClick, this.title});

  @override
  State<LocationMap> createState() => LocationMapState();
}

class LocationMapState extends State<LocationMap> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return FloatingCard(
      padding: EdgeInsets.zero,
      radius: 12.r,
      child: Column(
        children: [
          SizedBox(
            height: 160.h,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: context.appColors.onBackground,
                    ),
                    child: IgnorePointer(
                      ignoring: true,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: widget.latlng!,
                          zoom: 15.0,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _mapController.complete(controller);
                        },
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        myLocationButtonEnabled: false,
                      ),
                    ).clip(12.r),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Icon(
                      Icons.location_on,
                      color: context.appColors.primary,
                      size: 48.h,
                    ),
                  ),
                ),
                Positioned(
                  left: 0.w,
                  right: 0.w,
                  top: 0.h,
                  bottom: 0,
                  child: SlideWrapper(
                    slideDirection: SlideDirection.down,
                    initialOffset: 10,
                    duration: const Duration(seconds: 1),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.7),
                            Colors.black.withValues(alpha: 0.4),
                            Colors.black.withValues(alpha: 0.1),
                            Colors.black.withValues(alpha: 0.04),
                            Colors.black.withValues(alpha: 0.04),
                            Colors.black.withValues(alpha: 0.04),
                          ],
                          //    stops: [0.8, 1.0],
                        ),
                      ),
                    ).clipTop(12.r),
                  ),
                ),
              ],
            ).clickable(widget.onClick, radius: 12.r),
          ),
          if (widget.title != null)
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.location_on,
                  color: context.appColors.primary,
                  size: 16.h,
                ),
                4.gap,
                Expanded(
                  child: Text(
                    widget.title!,
                    textAlign: TextAlign.start,
                    style: TextStyles.semiBold12(context: context),
                  ),
                ),
              ],
            ).marginVertical(8.h).marginHorizontal(8.w),
        ],
      ),
    );
  }
}

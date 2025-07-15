import 'dart:async';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/app_map_styles.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/theme/color/app_colors.dart';
import 'package:decorizer/common/util/maps_util.dart';
import 'package:decorizer/common/widget/animations/slide.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_loading.dart';
import 'package:decorizer/common/widget/spaces.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nav/nav.dart';

class PickLocationScreen extends StatefulWidget {
  final Function(LatLng?) onSaveLocation;
  final LatLng? initialLocation;

  const PickLocationScreen(
      {super.key, required this.onSaveLocation, this.initialLocation});

  @override
  State<PickLocationScreen> createState() => PickLocationScreenState();
}

class PickLocationScreenState extends State<PickLocationScreen> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  LatLng? currentLatLng;
  String? _mapStyle;

  @override
  void dispose() {
    currentLatLng = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    MapsUtil.requestLocationPermission(onGranted: () {
      if (widget.initialLocation == null) {
        _getCurrentLocation();
      } else {
        setState(() {
          currentLatLng = widget.initialLocation;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    rootBundle
        .loadString(
      // context.isDarkMode ? AppMapStyles.darkStyle :
      AppMapStyles.partners,
    )
        .then((style) {
      _mapStyle = style;
      try {
        _mapController.future.then(
          (GoogleMapController controller) {
            controller.setMapStyle(_mapStyle);
          },
        );
      } catch (_) {}
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (currentLatLng == null) ...{
            Positioned(
              top: 0.h,
              bottom: 0,
              left: 0,
              right: 0,
              child: const Center(
                child: AppLoading(),
              ),
            ),
          } else ...{
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: currentLatLng!,
                zoom: 15.0,
              ),
              onCameraMove: (CameraPosition newPosition) {
                setState(() {
                  currentLatLng = LatLng(newPosition.target.latitude,
                      newPosition.target.longitude);
                });
              },
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
                if (_mapStyle != null) {
                  controller.setMapStyle(_mapStyle);
                }
              },
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              compassEnabled: false,
            ),
            Center(
              child: Icon(
                Icons.location_on,
                color: context.isDarkMode
                    ? AppColors.yellow
                    : context.appColors.primary,
                size: 36.0,
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              top: 0.h,
              child: IgnorePointer(
                ignoring: true,
                child: SlideWrapper(
                  slideDirection: SlideDirection.down,
                  initialOffset: 90,
                  duration: const Duration(seconds: 1),
                  child: Container(
                      decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.6),
                        Colors.black.withValues(alpha: 0.5),
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0),
                      ],
                      //    stops: [0.8, 1.0],
                    ),
                  )),
                ),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              bottom: 0.h,
              child: IgnorePointer(
                ignoring: true,
                child: SlideWrapper(
                  slideDirection: SlideDirection.up,
                  initialOffset: 90,
                  duration: const Duration(seconds: 1),
                  child: Container(
                      decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0),
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.5),
                        Colors.black.withValues(alpha: 0.6),
                      ],
                      //    stops: [0.8, 1.0],
                    ),
                  )),
                ),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 20.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FloatingActionButton(
                      onPressed: () async {
                        await _getCurrentLocation();
                        if (currentLatLng != null) {
                          _mapController.future.then(
                            (controller) {
                              controller.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                      target: currentLatLng!, zoom: 15),
                                ),
                              );
                            },
                          );
                        }
                      },
                      backgroundColor: context.appColors.primary,
                      child: Icon(
                        Icons.my_location,
                        color: context.appColors.white,
                      ),
                    ),
                    Height(10),
                    AppButton(
                      text: LocaleKeys.action_save.tr(),
                      onClick: () {
                        saveSelectedLocation(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          },
          Positioned(
            top: 45.h,
            child: BackButton(
              color: context.appColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLatLng = LatLng(position.latitude, position.longitude);
    });
  }

  void saveSelectedLocation(BuildContext context) {
    Nav.pop(context);
    widget.onSaveLocation(currentLatLng);
  }
}

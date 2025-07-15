import 'package:decorizer/common/extentions/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../common/util/intent_util.dart';

import '../../../../common/widget/location_map.dart';
import '../../domain/models/worker_order_details_model.dart';


class WorkerOrderLocationWidget extends StatelessWidget {

  const WorkerOrderLocationWidget({
    super.key,
    required this.orderDetails
  });
  final WorkerOrderDetailsModel orderDetails;

  @override
  Widget build(BuildContext context) {
    return  LocationMap(
      title: orderDetails.locationDescription,
      latlng: LatLng(
        orderDetails.lat ?? 0,
        orderDetails.long ?? 0,
      ),
      onClick: () {
        openMapsApp(
            orderDetails.lat ?? 0, orderDetails.long ?? 0);
      },
    ).marginHorizontal(16.w).marginVertical(12.h);
  }
}

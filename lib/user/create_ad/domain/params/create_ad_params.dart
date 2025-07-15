import 'dart:io';

import 'package:decorizer/common/util/compress_util.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateAdParams {
  final String title;
  final String content;
  final String budget;
  final String? numberOfDays;
  final String? locationDescription;
  final String governorateId;
  final String cityId;
  final List<int> types;
  final LatLng location;
  final List<File> images;

  CreateAdParams({
    required this.title,
    required this.content,
    required this.budget,
    required this.numberOfDays,
    required this.locationDescription,
    required this.governorateId,
    required this.cityId,
    required this.types,
    required this.location,
    required this.images,
  });

  Future<Map<String, dynamic>> toJson() async {
    final List<MultipartFile> imagesMultiparts =
        await CompressUtil.compressListOfImagesToMultiPart(images);
    return {
      'title': title,
      'content': content,
      'budget': budget,
      if (numberOfDays != null) 'number_of_days': numberOfDays,
      'governorate_id': governorateId,
      'city_id': cityId,
      'types[]': types,
      'lat': location.latitude,
      'long': location.longitude,
      if (locationDescription != null) 'location': locationDescription,
      'files[]': imagesMultiparts,
    };
  }
}

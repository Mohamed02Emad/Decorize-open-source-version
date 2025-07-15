import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import '../theme/color/app_colors.dart';

class MapsUtil {
  static Future<String> getStreetName(
      LatLng latLng, {
        BuildContext? context,
      }) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        final firstPlacemark = placemarks.first;
        if (firstPlacemark.street != null &&
            firstPlacemark.street!.isNotEmpty) {
          return firstPlacemark.street!;
        } else if (firstPlacemark.locality != null &&
            firstPlacemark.locality!.isNotEmpty) {
          return firstPlacemark.locality!;
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error fetching address information: $e');
      }
      return 'LatLng: (${latLng.latitude.toStringAsFixed(6)}, ${latLng.longitude.toStringAsFixed(6)})';
    }
    return 'LatLng: (${latLng.latitude.toStringAsFixed(6)}, ${latLng.longitude.toStringAsFixed(6)})';
  }

  static double calculateDistanceInKilometers(LatLng start, LatLng end) {
    const double earthRadius = 6371.0; // Earth's radius in kilometers

    double dLat = _degreesToRadians(end.latitude - start.latitude);
    double dLng = _degreesToRadians(end.longitude - start.longitude);

    double a =
        sin(dLat / 2) * sin(dLat / 2) +
            cos(_degreesToRadians(start.latitude)) *
                cos(_degreesToRadians(end.latitude)) *
                sin(dLng / 2) *
                sin(dLng / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  static Future<Marker> createMarker({
    required LatLng position,
    required String markerId,
    required String imagePath,
    int markerWidth = 150,
    String? title,
    required Function(LatLng) onTap,
  }) async {
    Uint8List markerBytes = await _createMarkerIcon(imagePath, markerWidth);
    return Marker(
      markerId: MarkerId(markerId),
      position: position,
      onTap: () => onTap(position),
      icon: BitmapDescriptor.fromBytes(markerBytes),
      infoWindow: InfoWindow(title: title),
      draggable: false,
    );
  }

  static Future<Uint8List> _createMarkerIcon(
      String imagePath,
      int width,
      ) async {
    // Load image bytes
    final imageBytes =
    imagePath.startsWith('http')
        ? await _getBytesFromNetworkImage(imagePath, width)
        : await _getBytesFromAsset(imagePath, width);

    // Decode the image
    ui.Codec imageCodec = await ui.instantiateImageCodec(imageBytes);
    ui.FrameInfo imageFrame = await imageCodec.getNextFrame();

    // Create canvas for the custom marker
    final pictureRecorder = ui.PictureRecorder();
    final canvas = ui.Canvas(pictureRecorder);
    final paint = Paint()..color = AppColors.primary; // Marker background color
    final double radius = width / 2;

    // Draw the main circle (outer marker)
    canvas.drawCircle(Offset(radius, radius), radius, paint);

    // Clip the image to fit inside the circle
    final double padding = 4.0; // Padding around the image
    final double innerRadius = radius - padding;

    // Define the source and destination rectangles
    final Rect srcRect = Rect.fromLTWH(
      0,
      0,
      imageFrame.image.width.toDouble(),
      imageFrame.image.height.toDouble(),
    );

    final Rect dstRect = Rect.fromCircle(
      center: Offset(radius, radius),
      radius: innerRadius,
    );

    // Draw the image inside the circle, scaling and centering it
    canvas.save();
    canvas.clipPath(ui.Path()..addOval(dstRect));
    canvas.drawImageRect(imageFrame.image, srcRect, dstRect, Paint());
    canvas.restore();

    // Draw the triangular pointer below the circle
    final path = ui.Path();
    path.moveTo(radius - 10, radius * 2);
    path.lineTo(radius + 10, radius * 2);
    path.lineTo(radius, radius * 2.5);
    path.close();
    canvas.drawPath(path, paint);

    // Convert the canvas drawing to a Uint8List for the marker
    final markerImage = await pictureRecorder.endRecording().toImage(
      width,
      (width * 1.5).toInt(),
    );
    final byteData = await markerImage.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return byteData!.buffer.asUint8List();
  }

  static Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!.buffer.asUint8List();
  }

  static Future<Uint8List> _getBytesFromNetworkImage(
      String url,
      int width,
      ) async {
    final response = await http.get(Uri.parse(url));
    ui.Codec codec = await ui.instantiateImageCodec(
      response.bodyBytes,
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!.buffer.asUint8List();
  }

  static Future<void> requestLocationPermission({
    required Function onGranted,
  }) async {
    var status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      await onGranted();
    } else if (status.isDenied) {
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }
}
import 'dart:math' as math;

import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/context_extension.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/dynamic_container.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';

class ColorWheelDialog extends StatelessWidget {
  const ColorWheelDialog._({required this.onColorSelected});
  final Function(List<int>) onColorSelected;

  static void show(BuildContext context, Function(List<int>) onColorSelected) {
    showDialog(
      context: context,
      builder: (context) =>
          ColorWheelDialog._(onColorSelected: onColorSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Color?> selectedColor = ValueNotifier<Color?>(null);
    final ValueNotifier<Offset?> selectedPosition =
        ValueNotifier<Offset?>(null);
    final GlobalKey _colorWheelKey = GlobalKey();

    void handleColorSelection(dynamic details, BuildContext context) {
      // Get the RenderBox of the color wheel container
      final RenderBox? renderBox =
          _colorWheelKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      final Offset localPosition =
          renderBox.globalToLocal(details.globalPosition);

      // Calculate center of the color wheel
      const double wheelSize = 280;
      final Offset center = Offset(wheelSize / 2, wheelSize / 2);

      // Calculate distance from center
      final double dx = localPosition.dx - center.dx;
      final double dy = localPosition.dy - center.dy;
      final double distance = math.sqrt(dx * dx + dy * dy);

      // Check if touch is within the wheel
      if (distance <= wheelSize / 2) {
        // Calculate angle using standard mathematical convention
        // atan2(y, x) gives angle from positive x-axis
        double angle = math.atan2(dy, dx);

        // Convert to degrees and adjust for color wheel orientation
        // We want 0 degrees at the top, going clockwise
        // atan2 gives -180 to 180, we need 0 to 360
        angle = (angle * 180 / math.pi + 360) % 360;

        // Adjust to start from top (270 degrees in standard math)
        angle = (angle + 90) % 360;

        double saturation = (distance / (wheelSize / 2)).clamp(0.0, 1.0);

        // Convert HSV to RGB
        final HSVColor hsvColor =
            HSVColor.fromAHSV(1.0, angle, saturation, 1.0);
        final Color color = hsvColor.toColor();

        selectedColor.value = color;
        selectedPosition.value = localPosition;
      }
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.create_design_choose_color.tr(),
                    style: TextStyles.semiBold16(),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.grey),
                    splashRadius: 20,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              ValueListenableBuilder<Color?>(
                valueListenable: selectedColor,
                builder: (context, color, child) {
                  return DynamicContainer(
                    showChild: color != null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      margin: 20.edgeInsetsBottom,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[400]!),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'RGB(${color?.red ?? 0}, ${color?.green ?? 0}, ${color?.blue ?? 0})',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // Color Wheel
              SizedBox(
                key: _colorWheelKey,
                width: 280,
                height: 280,
                child: ValueListenableBuilder<Offset?>(
                  valueListenable: selectedPosition,
                  builder: (context, position, child) {
                    return CustomPaint(
                      painter: ColorWheelPainter(selectedPosition: position),
                      child: GestureDetector(
                        onPanDown: (details) =>
                            handleColorSelection(details, context),
                        onPanUpdate: (details) =>
                            handleColorSelection(details, context),
                        child: Container(
                          width: 280,
                          height: 280,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: AppButton(
                      text: LocaleKeys.action_cancel.tr(),
                      onClick: () => Navigator.of(context).pop(),
                      isBordered: true,
                      borderColor: context.appColors.grey_2,
                      textColor: context.appColors.grey_2,
                      backgroundColor: context.appColors.onBackground,
                    ),
                  ),
                  16.gap,
                  Expanded(
                    child: ValueListenableBuilder<Color?>(
                      valueListenable: selectedColor,
                      builder: (context, color, child) {
                        return AppButton(
                          enabled: color != null,
                          onClick: color != null
                              ? () {
                                  if (color != null) {
                                    final List<int> rgbColor = [
                                      color.red,
                                      color.green,
                                      color.blue
                                    ];
                                    onColorSelected(rgbColor);
                                  }
                                  Navigator.of(context).pop();
                                }
                              : null,
                          text: LocaleKeys.action_done.tr(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorWheelPainter extends CustomPainter {
  final Offset? selectedPosition;

  ColorWheelPainter({this.selectedPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Create gradient for the color wheel
    final Paint paint = Paint()..style = PaintingStyle.fill;

    // Draw color wheel segments with correct orientation
    for (int i = 0; i < 360; i++) {
      // Start from top (270 degrees in standard math) and go clockwise
      final double angle = (i + 270) * math.pi / 180;

      // Create radial gradient for each segment
      final Gradient gradient = RadialGradient(
        colors: [
          Colors.white,
          HSVColor.fromAHSV(1.0, i.toDouble(), 1.0, 1.0).toColor(),
        ],
        stops: const [0.0, 1.0],
      );

      paint.shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

      // Draw segment
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        angle,
        math.pi / 180,
        true,
        paint,
      );
    }

    // Draw inner white circle for better contrast
    final Paint innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.15, innerPaint);

    // Draw border
    final Paint borderPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius, borderPaint);

    // Draw selected position indicator
    if (selectedPosition != null) {
      final Paint indicatorPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;

      final Paint indicatorBorderPaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      // Draw white circle with black border
      canvas.drawCircle(selectedPosition!, 8, indicatorPaint);
      canvas.drawCircle(selectedPosition!, 8, indicatorBorderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is ColorWheelPainter) {
      return oldDelegate.selectedPosition != selectedPosition;
    }
    return true;
  }
}

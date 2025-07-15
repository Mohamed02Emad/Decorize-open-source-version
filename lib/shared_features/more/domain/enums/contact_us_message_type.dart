import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:flutter/material.dart';

enum ContactUsMessageType {
  complain,
  request,
  suggestion,
  work,
  other;

  String get displayName => tr(name);

  String get apiName => switch (this) {
        ContactUsMessageType.complain => 'complain',
        ContactUsMessageType.request => 'request',
        ContactUsMessageType.suggestion => 'suggestion',
        ContactUsMessageType.work => 'work',
        ContactUsMessageType.other => 'other',
      };

  static List<DropdownMenuItem<ContactUsMessageType>> get ddlList =>
      List<ContactUsMessageType>.from(ContactUsMessageType.values)
          .map((ContactUsMessageType type) {
        return DropdownMenuItem(
          value: type,
          child: Text(
            type.displayName,
            style: TextStyles.regular14(),
          ),
        );
      }).toList();
}

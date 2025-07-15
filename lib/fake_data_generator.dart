import 'dart:math';

import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/data/localization_name_model.dart';
import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/resources/gen/assets.gen.dart';
import 'package:decorizer/shared_features/static/domain/models/city_model.dart';
import 'package:decorizer/shared_features/static/domain/models/governorate_model.dart';
import 'package:decorizer/shared_features/static/domain/models/type_model.dart';
import 'package:decorizer/user/orders/domain/enums/order_details_state.dart';
import 'package:decorizer/user/orders/domain/models/order_model.dart';
import 'package:flutter/material.dart';

class FakeDataGenerator {
  static final List<String> jobs = [
    'Decoration Engineer',
    'Carpenter',
    'Painter',
    'Electrician'
  ];


  static final List<String> categories = [
    'Living Room',
    'Setting Room',
    'office'
  ];

  static final List<DropdownMenuItem> _fakeDDLs = [
    DropdownMenuItem(
      value: 1,
      child: Text(
        'option 1',
        style: TextStyles.regular11(),
      ),
    ),
    DropdownMenuItem(
      value: 2,
      child: Text(
        'option 2',
        style: TextStyles.regular11(),
      ),
    ),
    DropdownMenuItem(
      value: 3,
      child: Text(
        'option 3',
        style: TextStyles.regular11(),
      ),
    ),
  ];

  static List<GovernorateModel> governorates = [
    GovernorateModel(
        id: 1,
        name: LocalizedTextModel(en: 'Governorate 1', ar: 'Governorate 1')),
    GovernorateModel(
        id: 2,
        name: LocalizedTextModel(en: 'Governorate 2', ar: 'Governorate 2')),
    GovernorateModel(
        id: 3,
        name: LocalizedTextModel(en: 'Governorate 3', ar: 'Governorate 3')),
  ];

  static List<DropdownMenuItem> get fakeDropDownItems {
    return _fakeDDLs;
  }

  static List<OrderModel> get fakeOrders {
    return [
      OrderModel(
        id: 1,
        title: 'Order 1',
        content: 'Description 1',
        files: [
          ImageModel(
            id: 1,
            url: 'https://shorturl.at/ACOpQ',
          ),
        ],
        budget: '100',
        numberOfDays: 10,
        governorate: GovernorateModel(
            id: 1,
            name: LocalizedTextModel(en: 'Governorate 1', ar: 'Governorate 1')),
        city: CityModel(
            id: 1, name: LocalizedTextModel(en: 'City 1', ar: 'City 1')),
        slug: 'order-1',
        lat: 10.0,
        long: 10.0,
        status: OrderDetailsState.random,
        types: [
          TypeModel(
              id: 1, name: LocalizedTextModel(en: 'Type 1', ar: 'Type 1')),
          TypeModel(
              id: 2, name: LocalizedTextModel(en: 'Type 2', ar: 'Type 2')),
          TypeModel(
              id: 3, name: LocalizedTextModel(en: 'Type 3', ar: 'Type 3')),
        ],
      ),
    ];
  }

  static String get randomFakeImage {
    final randomImages = [
      'https://shorturl.at/ACOpQ',
      'https://shorturl.at/jkMB6',
      'https://shorturl.at/LX8pE',
      'https://shorturl.at/NKy9p',
      'https://shorturl.at/VZpYT',
    ];
    return randomImages.elementAt(Random().nextInt(randomImages.length));
  }

  static List<FakeCategory> get getFakeCategories {
    return [
      FakeCategory(1, 'Category 1', Assets.image.svg.chat.path),
      FakeCategory(2, 'Category 2', Assets.image.svg.date.path),
      FakeCategory(3, 'Category 3', Assets.image.svg.calendar.path),
      FakeCategory(4, 'Category 4', Assets.image.svg.edit.path),
      FakeCategory(5, 'Category 5', Assets.image.svg.language.path),
    ];
  }
}

class FakeCategory {
  final int id;
  final String name;
  final String image;

  FakeCategory(this.id, this.name, this.image);
}

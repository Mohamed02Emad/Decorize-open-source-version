import 'dart:io';

import 'package:decorizer/shared_features/static/domain/models/city_model.dart';
import 'package:decorizer/shared_features/static/domain/models/governorate_model.dart';
import 'package:decorizer/shared_features/static/domain/models/type_model.dart';
import 'package:decorizer/user/create_ad/domain/params/create_ad_params.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

mixin CreateAdCubitVariables {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationDescriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // final ValueNotifier<String?> selectedCategory = ValueNotifier(null);
  final ValueNotifier<List<TypeModel>?> selectedJobs = ValueNotifier([]);
  final ValueNotifier<List<File>?> pickedImages = ValueNotifier(null);
  final ValueNotifier<LatLng?> userLocationNotifier = ValueNotifier(null);
  final ValueNotifier<GovernorateModel?> selectedGovernorate = ValueNotifier(null);
  final ValueNotifier<CityModel?> selectedCity = ValueNotifier(null);

  CreateAdParams get createAdParams => CreateAdParams(
        title: nameController.text,
        content: descriptionController.text,
        budget: priceController.text,
        numberOfDays: null,
        locationDescription: locationDescriptionController.text.isNotEmpty ? locationDescriptionController.text : null,
        governorateId: selectedGovernorate.value?.id.toString() ?? '',
        cityId: selectedCity.value?.id.toString() ?? '',
        types: selectedJobs.value?.map((e) => e.id).toList() ?? [],
        location: userLocationNotifier.value!,
        images: pickedImages.value ?? [],
  );


  void disposeVariables() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    // selectedCategory.dispose();
    selectedJobs.dispose();
    formKey.currentState?.dispose();
    pickedImages.dispose();
    userLocationNotifier.dispose();
  }
}

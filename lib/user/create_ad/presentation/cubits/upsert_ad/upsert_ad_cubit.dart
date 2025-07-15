import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/user/create_ad/domain/usecases/create_ad_usecase.dart';
import 'package:decorizer/user/create_ad/domain/usecases/update_ad_usecase.dart';
import 'package:decorizer/user/create_ad/presentation/cubits/upsert_ad/upsert_ad_cubit_variables.dart';
import 'package:decorizer/user/orders/domain/models/order_details_model.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'upsert_ad_state.dart';

@Injectable()
class UpsertAdCubit extends BaseCubit<UpsertAdState>
    with UpsertAdCubitVariables {
  final CreateAdUsecase createAdUsecase;
  final UpdateAdUsecase updateAdUsecase;

  UpsertAdCubit(this.createAdUsecase, this.updateAdUsecase)
      : super(UpsertAdState.initial());

  void initData(OrderDetailsModel? orderDetailsModel) {
    if (orderDetailsModel != null) {
      isUpdating = true;
      orderId = orderDetailsModel.id.toString();

      // Populate form fields with existing data
      nameController.text = orderDetailsModel.title;
      priceController.text = orderDetailsModel.budget;
      descriptionController.text = orderDetailsModel.content;
      locationDescriptionController.text =
          orderDetailsModel.locationDescription ?? '';

      // Set selected values
      selectedJobs.value = orderDetailsModel.types;
      selectedGovernorate.value = orderDetailsModel.governorate;
      selectedCity.value = orderDetailsModel.city;

      // Set location if available
      if (orderDetailsModel.lat != null && orderDetailsModel.long != null) {
        userLocationNotifier.value = LatLng(
          orderDetailsModel.lat!,
          orderDetailsModel.long!,
        );
      }

      // Convert images to display format if needed
      // Note: This might need adjustment based on how images are handled in the UI
      // pickedImages.value = orderDetailsModel.files.map((e) => File(e.path)).toList();
    }
  }

  Future<void> saveAd() async {
    if (state.upsertAdState.isLoading) return;

    if (isUpdating) {
      await _updateAd();
    } else {
      await _createAd();
    }
  }

  Future<void> _createAd() async {
    callAndFold(
      future: createAdUsecase(createAdParams),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(upsertAdState: requestState)),
    );
  }

  Future<void> _updateAd() async {
    callAndFold(
      future: updateAdUsecase(updateAdParams),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(upsertAdState: requestState)),
    );
  }
}

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/custom_selection_field.dart';
import 'package:decorizer/common/widget/custom_selection_field_multi_select.dart';
import 'package:decorizer/common/widget/dynamic_container.dart';
import 'package:decorizer/common/widget/spaces.dart';
import 'package:decorizer/shared_features/static/domain/models/city_model.dart';
import 'package:decorizer/shared_features/static/domain/models/governorate_model.dart';
import 'package:decorizer/shared_features/static/domain/models/type_model.dart';
import 'package:decorizer/shared_features/static/presentation/cubits/cities/cities_cubit.dart';
import 'package:decorizer/shared_features/static/presentation/cubits/governates/governates_cubit.dart';
import 'package:decorizer/shared_features/static/presentation/cubits/types/types_cubit.dart';
import 'package:decorizer/user/create_ad/presentation/cubits/upsert_ad/upsert_ad_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpsertAdDropDownsSection extends StatelessWidget {
  const UpsertAdDropDownsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpsertAdCubit>();
    final governatesCubit = context.read<GovernatesCubit>();
    final citiesCubit = context.read<CitiesCubit>();
    final typesCubit = context.read<TypesCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
          valueListenable: cubit.selectedJobs,
          builder: (context, selectedJobs, child) =>
              BlocBuilder<TypesCubit, TypesState>(
            builder: (context, state) =>
                CustomSelectionFieldMultiSelect<TypeModel>(
              isLoading: state.typesState.isLoading,
              title: context.tr(LocaleKeys.create_ad_jobs),
              hint: context.tr(LocaleKeys.create_ad_select_job),
              futureRequest: () async {
                final types = typesCubit.state.typesState.data ?? [];
                if (types.isNotEmpty) {
                  return types;
                }
                await typesCubit.getTypes();
                return typesCubit.state.typesState.data ?? [];
              },
              itemToString: (item) => item?.name.trans() ?? '',
              initialValues: selectedJobs,
              onChanged: (selectedItems) {
                _onJobChanged(context, selectedItems);
              },
              validator: (selectedItems) {
                if (selectedItems == null || selectedItems.isEmpty) {
                  return context.tr(LocaleKeys.validation_empty_job);
                }
                return null;
              },
            ),
          ),
        ),
        Height(12.h),
        ValueListenableBuilder(
          valueListenable: cubit.selectedGovernorate,
          builder: (context, selectedGovernorate, child) => Column(
            children: [
              BlocBuilder<GovernatesCubit, GovernatesState>(
                builder: (context, state) =>
                    CustomSelectionField<GovernorateModel>(
                  isLoading: state.governatesState.isLoading,
                  title: context.tr(LocaleKeys.common_governorate),
                  hint: context.tr(LocaleKeys.common_governorate),
                  futureRequest: () async {
                    final governorates =
                        governatesCubit.state.governatesState.data ?? [];
                    if (governorates.isNotEmpty) {
                      return governorates;
                    }
                    await governatesCubit.getGovernorates();
                    return governatesCubit.state.governatesState.data ?? [];
                  },
                  itemToString: (item) => item?.name.trans() ?? '',
                  initialValue: selectedGovernorate,
                  onChanged: (governorate) {
                    _onGovernorateChanged(context, governorate);
                  },
                  validator: (governorate) {
                    if (governorate == null) {
                      return context
                          .tr(LocaleKeys.validation_empty_governorate);
                    }
                    return null;
                  },
                ),
              ),
              DynamicContainer(
                showChild: selectedGovernorate != null,
                child: ValueListenableBuilder(
                  valueListenable: cubit.selectedCity,
                  builder: (context, selectedCity, child) =>
                      CustomSelectionField<CityModel>(
                    title: context.tr(LocaleKeys.common_city),
                    hint: context.tr(LocaleKeys.common_city),
                    futureRequest: () async {
                      await citiesCubit.getCities(selectedGovernorate!.id);
                      return citiesCubit.state.citiesState.data ?? [];
                    },
                    itemToString: (item) => item?.name.trans() ?? '',
                    initialValue: selectedCity,
                    onChanged: (city) {
                      _onCityChanged(context, city);
                    },
                    validator: (city) {
                      if (city == null) {
                        return context.tr(LocaleKeys.validation_empty_city);
                      }
                      return null;
                    },
                  ).marginTop(12.h),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onJobChanged(BuildContext context, List<TypeModel>? selectedItems) {
    final cubit = context.read<UpsertAdCubit>();
    cubit.selectedJobs.value = selectedItems ?? [];
  }

  void _onGovernorateChanged(
      BuildContext context, GovernorateModel? governorate) {
    final cubit = context.read<UpsertAdCubit>();
    cubit.selectedGovernorate.value = governorate;
    cubit.selectedCity.value = null;
    if (governorate != null) {
      _loadCitiesForGovernorate(context, governorate);
    }
  }

  void _loadCitiesForGovernorate(
      BuildContext context, GovernorateModel governorate) {
    final cubit = context.read<CitiesCubit>();
    cubit.getCities(governorate.id);
  }

  void _onCityChanged(BuildContext context, CityModel? city) {
    final cubit = context.read<UpsertAdCubit>();
    cubit.selectedCity.value = city;
  }
}

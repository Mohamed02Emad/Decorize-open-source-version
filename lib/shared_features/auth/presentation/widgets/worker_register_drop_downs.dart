import 'package:decorizer/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../static/domain/models/city_model.dart';
import '../../../static/domain/models/governorate_model.dart';
import '../../../static/domain/models/type_model.dart';
import '../../../static/presentation/cubits/cities/cities_cubit.dart';
import '../../../static/presentation/cubits/governates/governates_cubit.dart';
import '../../../../common/widget/custom_selection_field.dart';
import '../../../../common/resources/gen/locale_keys.g.dart';
import '../../../static/presentation/cubits/types/types_cubit.dart';

class WorkerRegisterDropDownsSection extends StatefulWidget {
  WorkerRegisterDropDownsSection({
    Key? key,
    required this.selectedJob,
    required this.selectedGovernorate,
    required this.selectedCity,
  }) : super(key: key);

  final ValueNotifier<TypeModel?> selectedJob;
  final ValueNotifier<GovernorateModel?> selectedGovernorate;
  final ValueNotifier<CityModel?> selectedCity;
  @override
  State<WorkerRegisterDropDownsSection> createState() =>
      _WorkerRegisterDropDownsSectionState();
}

class _WorkerRegisterDropDownsSectionState
    extends State<WorkerRegisterDropDownsSection> {
  @override
  Widget build(BuildContext context) {
    final governatesCubit = context.read<GovernatesCubit>();
    final citiesCubit = context.read<CitiesCubit>();
    final typesCubit = context.read<TypesCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
          valueListenable: widget.selectedJob,
          builder: (context, selectedJob, child) =>
              BlocBuilder<TypesCubit, TypesState>(
            builder: (context, state) => CustomSelectionField<TypeModel>(
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
              initialValue: selectedJob,
              onChanged: (selecteditem) {
                widget.selectedJob.value = selecteditem;
              },
              validator: (selectedJob) {
                if (selectedJob == null) {
                  return context.tr(LocaleKeys.validation_empty_job);
                }
                return null;
              },
            ),
          ),
        ),
        SizedBox(height: 12.h),
        ValueListenableBuilder(
          valueListenable: widget.selectedGovernorate,
          builder: (context, selectedGovernorate, child) =>
              BlocBuilder<GovernatesCubit, GovernatesState>(
            builder: (context, state) {
              return CustomSelectionField<GovernorateModel>(
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
                  if (mounted) {
                    widget.selectedGovernorate.value = governorate;
                    widget.selectedCity.value = null;
                  }
                  if (governorate != null) {
                    citiesCubit.getCities(governorate.id);
                  }
                },
                validator: (value) => value == null
                    ? context.tr(LocaleKeys.validation_empty_governorate)
                    : null,
              );
            },
          ),
        ),
        SizedBox(height: 12.h),
        if (widget.selectedGovernorate != null)
          ValueListenableBuilder(
            valueListenable: widget.selectedCity,
            builder: (context, selectedCity, child) =>
                BlocBuilder<CitiesCubit, CitiesState>(
                    builder: (context, state) {
                      return CustomSelectionField<CityModel>(
                title: context.tr(LocaleKeys.common_city),
                hint: context.tr(LocaleKeys.common_city),
                futureRequest: () async {
                  await citiesCubit
                      .getCities(widget.selectedGovernorate.value!.id);
                  return citiesCubit.state.citiesState.data ?? [];
                },
                itemToString: (item) => item?.name.trans() ?? '',
                initialValue: selectedCity,
                onChanged: (city) {
                  setState(() {
                    widget.selectedCity.value = city;
                  });
                },
                validator: (value) => value == null
                    ? context.tr(LocaleKeys.validation_empty_city)
                    : null,
              );
            }),
          ),
      ],
    );
  }
}

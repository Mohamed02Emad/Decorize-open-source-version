import 'package:decorizer/shared_features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:decorizer/shared_features/auth/presentation/widgets/worker_register_form.dart';
import 'package:decorizer/shared_features/static/presentation/cubits/types/types_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/di/injection_container.dart';
import '../../../static/presentation/cubits/cities/cities_cubit.dart';
import '../../../static/presentation/cubits/governates/governates_cubit.dart';


class WorkerRegisterScreen extends StatelessWidget {
  const WorkerRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => sl<GovernatesCubit>()..getGovernorates()),
      BlocProvider(create: (context) => sl<CitiesCubit>()),
      BlocProvider(create: (context) => sl<RegisterCubit>()),
      BlocProvider(create: (context)=> sl<TypesCubit>()..getTypes()),
    ], child:  WorkerRegisterForm(),
    );
  }
}


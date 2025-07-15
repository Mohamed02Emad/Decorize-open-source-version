import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app_title_bar.dart';
import 'package:decorizer/common/widget/spaces.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/constant/textStyles.dart';
import '../../../../common/di/injection_container.dart';
import '../cubit/get_profile_cubit/worker_profile_cubit.dart';
import '../widgets/comments_section.dart';
import '../widgets/worker_gallery.dart';

class WorkerProfileScreen extends StatelessWidget {
  const WorkerProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => sl<WorkerProfileCubit>()..getWorkerProfile()
        ),
        BlocProvider(create: (context) => sl<LoginInfoCubit>())
      ],
        child: _WorkerProfileScreenBody()
    ) ;
  }
}

class _WorkerProfileScreenBody extends StatelessWidget {
  const _WorkerProfileScreenBody();

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppTitleBar(
      title: context.tr(LocaleKeys.edit_profile_profile),
      hasBackButton: true,
    ),
    body: BlocBuilder<WorkerProfileCubit, WorkerProfileState>(
      builder: (context, state) {
        if (state.getWorkerProfileState.isSuccess) {
          final worker = state.getWorkerProfileState.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                CircleAvatar(
                  radius: 35.r,
                  backgroundImage: NetworkImage(
                    worker.image!,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  worker.name,
                  style: TextStyles.semiBold14(context: context,),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    SizedBox(width: 4.w),
                    Text(
                      worker.averageRate.toString(),
                      style: TextStyles.regular12Weight400(context:  context),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '| ${worker.profession}',
                      style:  TextStyles.regular14Weight400(context:  context),
                    ),
                  ],
                ),
                Height(15.h),
                WorkerGallery(gallery :worker.gallery),
                Height(12.h),
                WorkerComments(worker: worker,),
                const SizedBox(height: 36),
              ],
            ),
          );
        } else if (state.getWorkerProfileState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    ),
  );
}

}

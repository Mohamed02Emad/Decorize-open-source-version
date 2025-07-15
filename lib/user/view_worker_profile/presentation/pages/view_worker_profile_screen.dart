import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/util/system_bars_util.dart';
import 'package:decorizer/common/widget/app_title_bar.dart';
import 'package:decorizer/common/widget/dynamic_sliver_app_bar.dart';
import 'package:decorizer/user/view_worker_profile/presentation/widgets/profile_header.dart';
import 'package:decorizer/user/view_worker_profile/presentation/widgets/rates_and_comments_section.dart';
import 'package:flutter/material.dart';

import '../widgets/portfolio_section.dart';

class ViewWorkerProfileScreen extends StatefulWidget {
  const ViewWorkerProfileScreen({super.key});

  @override
  State<ViewWorkerProfileScreen> createState() =>
      _ViewWorkerProfileScreenState();
}

class _ViewWorkerProfileScreenState extends State<ViewWorkerProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitleBar(
        title: "الملف الشخصي",
        centerTitle: true,
        hasBackButton: true,
        addSafeAreaSpace: true,
        backgroundColor: context.appColors.primary,
        textColor: context.appColors.white,
        radius: 0,
        isElevated: false,
      ),
      body: CustomScrollView(
        slivers: [
          DynamicSliverAppBar(
            child: ProfileHeader(),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                PortfolioSection(),
                RatesAndCommentsSection(
                  ratesDistribution: {
                    '1': 10,
                    '2': 0,
                    '3': 15,
                    '4': 20,
                    '5': 50,
                  },
                  avgRates: 3.9,
                ),
                10.gap,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

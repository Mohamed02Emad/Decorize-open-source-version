import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/app/floating_card.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_error_widget.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_loading.dart';
import 'package:decorizer/common/widget/app_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/di/injection_container.dart';
import '../../../../common/util/intent_util.dart';
import '../../domain/enums/static_page_type.dart';
import '../../domain/params/static_pages_params.dart';
import '../cubits/static_pages/static_pages_cubit.dart';

class StaticPagesScreen extends StatelessWidget {
  final StaticPageType type;

  const StaticPagesScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<StaticPagesCubit>(),
      child: _StaticPagesBody(type: type),
    );
  }
}

class _StaticPagesBody extends StatefulWidget {
  final StaticPageType type;

  const _StaticPagesBody({required this.type});

  @override
  State<_StaticPagesBody> createState() => _StaticPagesBodyState();
}

class _StaticPagesBodyState extends State<_StaticPagesBody> {
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      body: Column(
        children: <Widget>[
          AppTitleBar(
            title: widget.type.displayName,
            hasBackButton: true,
          ),
          Expanded(
            child: BlocBuilder<StaticPagesCubit, StaticPagesState>(
              builder: (BuildContext context, StaticPagesState state) {
                if (state.staticPagesState.isSuccess) {
                  final String data = state.staticPagesState.data?.data ?? '';
                  return Container(
                    padding: EdgeInsets.only(
                        top: 16.h, left: 16.h, right: 16.h, bottom: 16.h),
                    child: FloatingCard(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Html(
                              data: data,
                              onLinkTap: (url, attributes, element) {
                                if (url != null) {
                                  openWebIntent(url: url);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state.staticPagesState.isError) {
                  return AppErrorWidget(
                          errorMessage: state.staticPagesState.message!)
                      .marginBottom(170.h);
                } else {
                  return const AppLoading(
                    size: 100,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _loadData() {
    final StaticPagesParams params = StaticPagesParams(type: widget.type);
    context.read<StaticPagesCubit>().getStaticPage(params);
  }
}
